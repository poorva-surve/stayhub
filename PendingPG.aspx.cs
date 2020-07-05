using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void DataListFullPG_PreRender(object sender, EventArgs e)
    {
        try
        {
            /*Retrieving Owner name*/
            DataListItem dli = DataListFullPG.Items[0] as DataListItem;
            Label lblOwnerID = dli.FindControl("lblOwner") as Label;
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
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
    protected void btnApprove_Click(object sender, EventArgs e)
    {
        try
        {
            //DateTime expiry = DateTime.Now.AddMonths(1);
            DateTime expiry = DateTime.Now.AddYears(5);
            DateTime added = DateTime.Now.AddSeconds(1);

            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);


            String setEx = "update PG set ExpiryDate= @ex, DateAdded = @ad where ID = @id";

            SqlCommand cmd = new SqlCommand(setEx, con);
            cmd.Parameters.AddWithValue("ex", expiry);
            cmd.Parameters.AddWithValue("ad", added);
            cmd.Parameters.AddWithValue("id", Request.QueryString["id"]);

            con.Open();
            cmd.ExecuteNonQuery();

            con.Close();

            DataListFullPG.Visible = false;
            btnApprove.Visible = false;
            btnDelete.Visible = false;
            lblEmpty.Text = "PG Approved Successfully";
            lblEmpty.ForeColor = System.Drawing.Color.Green;
            lblEmpty.Visible = true;
            linkBack.Visible = true;
            linkAll.Visible = true;
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);
            String delPG = "delete from PG where ID = @id";
            SqlCommand cmd = new SqlCommand(delPG, con);
            cmd.Parameters.AddWithValue("id", Request.QueryString["id"]);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            DataListFullPG.Visible = false;
            btnApprove.Visible = false;
            btnDelete.Visible = false;
            lblEmpty.Text = "PG Removed Successfully";
            lblEmpty.ForeColor = System.Drawing.Color.Red;
            lblEmpty.Visible = true;
            linkBack.Visible = true;
            linkAll.Visible = true;
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
}