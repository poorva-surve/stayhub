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
    String uid = "";
    String uname = "";
    String utype = "";
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
       
            if (txtUser.Text == "admin" && txtUserPass.Text == "admin")
            {
                Session["admin"] = "Admin";
                Response.Redirect("Admin.aspx");
                Session.RemoveAll();
            }
            else
            {
                LogUser();
            }
        
    }

    protected void LogUser()
    {
        
            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);
            SqlCommand cmd = new SqlCommand("select * from Users where Email=@email and Password=@pass", con);
            cmd.Parameters.AddWithValue("email", txtUser.Text);
            cmd.Parameters.AddWithValue("pass", txtUserPass.Text);

            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                uid = reader[0].ToString();
                uname = reader[1].ToString();
                utype = reader[2].ToString();
            }


            if (reader.HasRows)
            {
                Session["id"] = txtUser.Text;
                if (utype == "Seeker")
                {
                    Session["user"] = uname;
                    Session["userid"] = uid;
                    Response.Redirect("Home.aspx");
                }
                else if (utype == "Owner")
                {
                    Session["owner"] = uname;
                    Session["ownerid"] = uid;
                    Response.Redirect("Owner.aspx");
                }
                Session.RemoveAll();
            }
            else
            {
                lblStatus.Text = "Incorrect username or password";
                lblStatus.ForeColor = System.Drawing.Color.Red;
            }

            con.Close();
        
    }

}