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


    protected void DataListExpiringPG_PreRender(object sender, EventArgs e)
    {
        try
        {
            String id = Session["ownerid"].ToString();
            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);
            String query = "select ExpiryDate from PG where OwnerID = @id and ExpiryDate <> '1900-01-01'";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("id", id);
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            int r = -1;

            while (reader.Read())
            {
                r++;

                DataListItem dli = DataListExpiringPG.Controls[r] as DataListItem;
                DateTime exp = DateTime.Parse(reader[0].ToString());


                Button b1 = dli.FindControl("btnReactivate") as Button;
                Button b2 = dli.FindControl("btnDeactivate") as Button;

                /*
                DateTime dt = DateTime.Now;
                int i = Int32.Parse((exp - dt).Days.ToString()) + 1;

            
                if (i <= 5)     //Less than 5 days remaining to expire
                {
                    b1.Enabled = true;
                }
                else            //Not expiring anytime soon
                {
                    b1.Enabled = false;
                    b1.BackColor = System.Drawing.Color.Gray;
                    b1.BorderColor = System.Drawing.Color.Gray;
                }
                */

                b1.Visible = false;
                b2.Visible = false;

                Label lblStatus = (Label)dli.FindControl("lblStatus");
                String status = lblStatus.Text;

                if (status == "Inactive")
                {
                    lblStatus.ForeColor = System.Drawing.Color.Red;
                    b1.Visible = true;
                }
                else if (status == "Active")
                    b2.Visible = true;
            }
            con.Close();
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
            if (e.CommandName == "deactivatePG")
            {
                String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
                SqlConnection con = new SqlConnection(myConn);
                //String delPG = "delete from PG where ID = @id";

                DateTime expiry = DateTime.Now;
                String setEx = "update PG set ExpiryDate= @ex where ID = @id";
                SqlCommand cmd = new SqlCommand(setEx, con);
                cmd.Parameters.AddWithValue("ex", expiry);
                cmd.Parameters.AddWithValue("id", e.CommandArgument.ToString());

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                DataListExpiringPG.DataBind();
            }
            else if (e.CommandName == "reactivatePG")
            {
                String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
                SqlConnection con = new SqlConnection(myConn);

                DateTime expiry = DateTime.Now.AddYears(5);
                String setEx = "update PG set ExpiryDate= @ex where ID = @id";
                SqlCommand cmd = new SqlCommand(setEx, con);
                cmd.Parameters.AddWithValue("ex", expiry);
                cmd.Parameters.AddWithValue("id", e.CommandArgument.ToString());

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                DataListExpiringPG.DataBind();


                /*
                String txnid = "";
                Random random = new Random();
                txnid = "StayHub" + (Convert.ToString(random.Next(10000, 20000)));

                Response.Write("<script>");
                Response.Write("window.open('RenewPG.aspx?id=" + id + "&txnid=" + txnid + "', '_blank')");
                Response.Write("</script>");
                */
            }
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
}