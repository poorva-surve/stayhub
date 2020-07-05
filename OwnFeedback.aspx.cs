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
        
            if (Session["id"] != null)
            {
                String uname = "";
                String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
                SqlConnection con = new SqlConnection(myConn);

                String query = "select Name from Users where Email = @email;";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("email", Session["id"].ToString());

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    uname = reader[0].ToString();
                }

                con.Close();
                lblName.Text = uname;
            }
        
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        
            String fname = "", ftext = "", freg = "";

            fname = lblName.Text;
            ftext = txtFeed.Text;
            freg = " (PG Owner)";



            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);
            String query = "insert into Feedback(Name, Feed, Timestamp) values (@name, @feed, @time);";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("name", fname + freg);
            cmd.Parameters.AddWithValue("feed", ftext);
            cmd.Parameters.AddWithValue("time", DateTime.Now);

            con.Open();
            int i = cmd.ExecuteNonQuery();
            con.Close();
            if (i > 0)
            {
                tblFB.Visible = false;
                lblStatus.Visible = true;
                lblStatus.Text = "Feedback Submitted Successfully";
                goFB.Visible = true;
            }
       
    }
}