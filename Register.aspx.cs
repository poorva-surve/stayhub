using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page
{
    String newuser = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void userRole_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (userRole.SelectedValue == "Owner")
        {
            ddlOccupation.Enabled = false;
            ddlOccupation.SelectedIndex = 0;
            //txtOcc.Text = "";
            txtOcc.Visible = false;
            RequiredFieldValidator3.Visible = false;
        }
        else
        {
            ddlOccupation.Enabled = true;
        }
    }
    //protected void imgDOB_Click(object sender, ImageClickEventArgs e)
    //{
    //    if (calDOB.Visible)
    //        calDOB.Visible = false;
    //    else
    //        calDOB.Visible = true;
    //}
    //protected void calDOB_SelectionChanged(object sender, EventArgs e)
    //{
    //    txtDOB.Text = calDOB.SelectedDate.ToShortDateString();
    //    calDOB.Visible = false;
    //}
    protected void ddlOccupation_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlOccupation.SelectedValue == "Other")
        {
            txtOcc.Visible = true;
        }
        else
            txtOcc.Visible = false;
    }

    
    protected void btnReg_Click(object sender, EventArgs e)
    {
       
            int v = VerifyUser();
            if (v == 0)
            {
                int i = SaveUser();
                if (i != 1)
                    lblRegStatus.Text = "Registration Failed. Please Try Again!";
                else
                {
                    //lblRegStatus.Text = "Registered Successfully!";
                    //Session["id"] = txtEmail.Text;
                    if (userRole.SelectedValue == "Owner")
                    {
                        Session["id"] = txtEmail.Text;
                        Session["ownerid"] = newuser;
                        Session["owner"] = txtName.Text;
                        Response.Redirect("Owner.aspx");
                    }
                    else if (userRole.SelectedValue == "Seeker")
                    {
                        Session["id"] = txtEmail.Text;
                        Session["userid"] = newuser;
                        Session["user"] = txtName.Text;
                        Response.Redirect("Home.aspx");
                    }
                    Session.RemoveAll();
                }
            }
        
    }



    /**************METHODS****************/
    public String generateUserId()
    {
        String userid = "";
        
            String pass = "01234567890123456789";
            Random r = new Random();
            char[] mypass = new char[8];
            for (int i = 0; i < 8; i++)
            {
                mypass[i] = pass[(int)(3 * r.NextDouble())];

            }
            userid = "USER" + new string(mypass);
            return userid;
        
    }

    

    public String getTenantType()
    {
        if (ddlOccupation.SelectedValue == "Other")
            return txtOcc.Text;
        else
            return ddlOccupation.SelectedValue;
    }
    public int VerifyUser()
    {
        
            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);
            SqlCommand cmd = new SqlCommand("select * from Users where Email=@email", con);
            cmd.Parameters.AddWithValue("email", txtEmail.Text);

            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                lblRegStatus.Text = "User already exists! Please try again with a different e-mail ID.";
                return 1;
            }
            return 0;
        
    }
    public int SaveUser()
    {
        
            newuser = generateUserId();
            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);
            String addUser = "insert into Users values (@ID, @Name, @Role, @Gender, @Tenant, @DOB, @City, @Mobile, @Email, @Pass)";
            SqlCommand cmd = new SqlCommand(addUser, con);
            cmd.Parameters.AddWithValue("ID", newuser);
            cmd.Parameters.AddWithValue("Name", txtName.Text);
            cmd.Parameters.AddWithValue("Role", userRole.SelectedValue);
            cmd.Parameters.AddWithValue("Gender", userGender.SelectedValue);
            cmd.Parameters.AddWithValue("Tenant", getTenantType());
            cmd.Parameters.AddWithValue("DOB", txtDOB.Text);
            cmd.Parameters.AddWithValue("City", txtUsrCity.Text);
            cmd.Parameters.AddWithValue("Mobile", txtMobile.Text);
            cmd.Parameters.AddWithValue("Email", txtEmail.Text);
            cmd.Parameters.AddWithValue("Pass", txtPass.Text);

            con.Open();
            int i = cmd.ExecuteNonQuery();
            con.Close();
            if (i > 0)
                return 1;
            else
                return 0;
        
    }

    //protected void ValidateDOB(object source, ServerValidateEventArgs v)
    //{

    //    string dt = v.Value;
    //    int day = Int32.Parse(dt.Substring(0, 2));
    //    int month = Int32.Parse(dt.Substring(3, 2));
    //    int year = Int32.Parse(dt.Substring(6, 4));
    //    if (day < 1 || day > 32 || month < 1 || month > 12 || year < 1940 || year > 2001)
    //        v.IsValid = false;

    //    switch (month)
    //    {
    //        case 4:
    //        case 6:
    //        case 9:
    //        case 11:
    //            if (day > 30)
    //                v.IsValid = false;
    //            break;
    //        case 2:
    //            if (day > 29)
    //                v.IsValid = false;
    //            if (!((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) && day > 28)
    //                v.IsValid = false;
    //            break;
    //        default:
    //            v.IsValid = true;
    //            break;
    //    }
    //}

}