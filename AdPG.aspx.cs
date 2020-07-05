using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] == null)
            Response.Redirect("Home.aspx");
    }
    
    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {
       
            if (e.CommandName == "deletePG")
            {
                String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
                SqlConnection con = new SqlConnection(myConn);
                String delPG = "delete from PG where ID = @id";
                SqlCommand cmd = new SqlCommand(delPG, con);
                cmd.Parameters.AddWithValue("id", e.CommandArgument.ToString());
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                DataList1.DataBind();
            }
            else if (e.CommandName == "viewFull")
            {
                String id = e.CommandArgument.ToString();
                Response.Redirect("FullPG.aspx?id=" + id);
            }
       
    }
    protected void DataList1_PreRender(object sender, EventArgs e)
    {
       
            int c = DataList1.Items.Count;
            for (int i = 0; i < c; i++)
            {
                DataListItem dli = DataList1.Controls[i] as DataListItem;
                Label lblStatus = dli.FindControl("lblStatus") as Label;
                String status = lblStatus.Text;

                if (status == "Inactive")
                    lblStatus.ForeColor = System.Drawing.Color.Red;

                Label lblOwnerID = dli.FindControl("lblOwnerID") as Label;
                Label lblID = dli.FindControl("lblID") as Label;

                String ownerName = "";
                String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
                SqlConnection con = new SqlConnection(myConn);
                String getOwner = "SELECT Name FROM Users where ID = (select @ownerid from PG where ID = @original_ID) ";
                SqlCommand cmd = new SqlCommand(getOwner, con);
                cmd.Parameters.AddWithValue("ownerid", lblOwnerID.Text);
                cmd.Parameters.AddWithValue("original_ID", lblID.Text);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    ownerName = reader[0].ToString();
                }
                con.Close();

                Label lblOwnerName = dli.FindControl("lblOwnerName") as Label;
                lblOwnerName.Text = ownerName;
            }
       
    }

    protected void ddlSorting_SelectedIndexChanged(object sender, EventArgs e)
    {
        filtering();
        sorting();
    }
    protected void btnApplyFilters_Click(object sender, EventArgs e)
    {
        filtering();
        sorting();
    }
    protected void sorting()
    {
        String sortParam = ddlSorting.SelectedValue;

        String sortQuery = "";
        if (sortParam == "latest")
            sortQuery = " order by PG.DateAdded desc, PG.Name asc";
        else if (sortParam == "name")
            sortQuery = " order by PG.Name";
        else if (sortParam == "nameD")
            sortQuery = " order by PG.Name desc";
        else if (sortParam == "city")
            sortQuery = " order by PG.City, PG.Name asc";
        else if (sortParam == "cityD")
            sortQuery = " order by PG.City desc, PG.Name asc";

        SqlDataSourcePG.SelectCommand += sortQuery;
    }
    
    public string[] selectedFiltersOfCheckBoxList(CheckBoxList chkList)
    {
        List<string> selectedFilters = new List<string>();

        foreach (ListItem item in chkList.Items)
        {
            if (item.Selected)
            {
                selectedFilters.Add("'"+item.Value+"'");
            }
        }
        return selectedFilters.ToArray();
    }

    protected void filtering()
    {

        String filterQuery = "";
        String[] filterValues = selectedFiltersOfCheckBoxList(chkFilters);
        int c = filterValues.Length;
        lblFilterCount.Text = c.ToString();


        if (filterValues.Length == 0)
        {
            filterQuery += " ";
        }
        else
        {
            String allcities = String.Join(",", filterValues);
            filterQuery += " and PG.City in (" + allcities + ")";

        }


        SqlDataSourcePG.SelectCommand += filterQuery;

    }
}