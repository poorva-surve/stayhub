using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (DataList1.Items.Count == 0)
        {
            lblEmpty.Text = "~ No pending PGs to show ~";
        }
    }

    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "approvePG")
            {
                //DateTime expiry = DateTime.Now.AddMonths(1);
                DateTime expiry = DateTime.Now.AddYears(5);
                DateTime added = DateTime.Now.AddSeconds(1);

                String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
                SqlConnection con = new SqlConnection(myConn);

                String setEx = "update PG set ExpiryDate = @ex, DateAdded = @ad where ID = @id";


                SqlCommand cmd3 = new SqlCommand(setEx, con);
                cmd3.Parameters.AddWithValue("ex", expiry);
                cmd3.Parameters.AddWithValue("ad", added);
                cmd3.Parameters.AddWithValue("id", e.CommandArgument.ToString());

                con.Open();

                cmd3.ExecuteNonQuery();

                con.Close();
                DataList1.DataBind();
                lblEmpty.Text = "PG Approved Successfully";
                lblEmpty.ForeColor = System.Drawing.Color.Green;
            }
            else if (e.CommandName == "deletePG")
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
                lblEmpty.Text = "PG Removed Successfully";
                lblEmpty.ForeColor = System.Drawing.Color.Red;
            }
            else if (e.CommandName == "viewFull")
            {
                String id = e.CommandArgument.ToString();
                //Response.Redirect("PendingPG.aspx?id=" + id);

                /* ---TO OPEN LINK IN NEW TAB--- */
                Response.Write("<script>");
                Response.Write("window.open('PendingPG.aspx?id=" + id + "', '_blank')");
                Response.Write("</script>");
            }
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
    protected void DataList1_PreRender(object sender, EventArgs e)
    {
        try
        {
            int c = DataList1.Items.Count;
            for (int i = 0; i < c; i++)
            {
                DataListItem dli = DataList1.Controls[i] as DataListItem;
                /*Retrieving Owner name*/
                Label lblOwnerID = dli.FindControl("lblOwnerID") as Label;
                Label lblID = dli.FindControl("lblID") as Label;

                String ownerName = "";
                String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
                SqlConnection con = new SqlConnection(myConn);
                String getOwner = "SELECT Name FROM Users where ID = (select @ownerid from PG where ID = @original_ID) ";
                SqlCommand cmd1 = new SqlCommand(getOwner, con);
                cmd1.Parameters.AddWithValue("ownerid", lblOwnerID.Text);
                cmd1.Parameters.AddWithValue("original_ID", lblID.Text);
                con.Open();
                SqlDataReader reader1 = cmd1.ExecuteReader();
                while (reader1.Read())
                {
                    ownerName = reader1[0].ToString();
                }
                con.Close();

                Label lblOwnerName = dli.FindControl("lblOwnerName") as Label;
                lblOwnerName.Text = ownerName;
            }
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
}