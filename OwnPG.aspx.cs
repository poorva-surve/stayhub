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
        if (Session["owner"] == null)
            Response.Redirect("Home.aspx");
    }

    protected void DataList1_PreRender(object sender, EventArgs e)
    {
        try
        {
            int c = DataList1.Items.Count;
            for (int i = 0; i < c; i++)
            {
                DataListItem dli = DataList1.Controls[i] as DataListItem;
                Label lblStatus = dli.FindControl("lblStatus") as Label;
                String status = lblStatus.Text;

                if (status == "Inactive")
                    lblStatus.ForeColor = System.Drawing.Color.Red;

                Label lblExpiry = dli.FindControl("lblExpiry") as Label;
                String exp = lblExpiry.Text;

                if (exp == "01-01-1900")
                    lblExpiry.Text = "Unapproved";
            }
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {
        try
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
                Response.Write("<script>");
                Response.Write("window.open('OwnerFullPG.aspx?id=" + id + "', '_blank')");
                Response.Write("</script>");
            }
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
    
}