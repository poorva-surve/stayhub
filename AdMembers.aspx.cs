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

    }


    protected void GridViewMembers_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        TableCell userid = GridViewMembers.Rows[e.RowIndex].Cells[0];
        TableCell role = GridViewMembers.Rows[e.RowIndex].Cells[2];

        try
        {
            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);

            con.Open();

            if (role.Text == "Owner")
            {
                String hasPG = "select count(*) from PG where OwnerID = @id";
                SqlCommand cmd1 = new SqlCommand(hasPG, con);
                cmd1.Parameters.AddWithValue("id", userid.Text);
                int count = Convert.ToInt32(cmd1.ExecuteScalar());

                if (count > 0)
                {
                    //For owner --> delete interests for his/her PGs
                    String delPGInterests = "delete from Interests where PID in (select ID from PG where OwnerID = @id)";
                    SqlCommand cmd5 = new SqlCommand(delPGInterests, con);
                    cmd5.Parameters.AddWithValue("id", userid.Text);
                    cmd5.ExecuteNonQuery();

                    String delPG = "delete from PG where OwnerID = @id";
                    SqlCommand cmd2 = new SqlCommand(delPG, con);
                    cmd2.Parameters.AddWithValue("id", userid.Text);
                    cmd2.ExecuteNonQuery();

                }
            }

            String delVisit = "delete from SiteVisits where SID = @id or OID = @id";
            SqlCommand cmd3 = new SqlCommand(delVisit, con);
            cmd3.Parameters.AddWithValue("id", userid.Text);
            cmd3.ExecuteNonQuery();

            //For seeker --> delete his/her interests
            String delInterest = "delete from Interests where UID = @id";
            SqlCommand cmd4 = new SqlCommand(delInterest, con);
            cmd4.Parameters.AddWithValue("id", userid.Text);
            cmd4.ExecuteNonQuery();

            con.Close();
        }

        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
}