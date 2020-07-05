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
        if (Session["id"] == null)
            Response.Redirect("Home.aspx");
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            lblEmpty.Visible = false;
            btnUpdate.Visible = false;
            btnCancel.Visible = true;
            btnSave.Visible = true;
            DataListItem dli = this.DataListProfile.Controls[this.DataListProfile.Controls.Count - 1] as DataListItem;

            Label lblName = dli.FindControl("lblName") as Label;
            Label lblID = dli.FindControl("lblID") as Label;
            Label lblCity = dli.FindControl("lblCity") as Label;
            Label lblRole = dli.FindControl("lblRole") as Label;
            Label lblDOB = dli.FindControl("lblDOB") as Label;
            Label lblGender = dli.FindControl("lblGender") as Label;
            Label lblMobile = dli.FindControl("lblMobile") as Label;
            Label lblEmail = dli.FindControl("lblEmail") as Label;
            Label lblPass = dli.FindControl("lblPass") as Label;
            Label lblConPass = dli.FindControl("lblConPass") as Label;

            TextBox txtName = dli.FindControl("txtName") as TextBox;
            TextBox txtCity = dli.FindControl("txtCity") as TextBox;
            TextBox txtDOB = dli.FindControl("txtDOB") as TextBox;
            TextBox txtMobile = dli.FindControl("txtMobile") as TextBox;
            TextBox txtEmail = dli.FindControl("txtEmail") as TextBox;
            TextBox txtPass = dli.FindControl("txtPass") as TextBox;
            TextBox txtConPass = dli.FindControl("txtConPass") as TextBox;

            DropDownList ddlRole = dli.FindControl("ddlRole") as DropDownList;
            DropDownList ddlGender = dli.FindControl("ddlGender") as DropDownList;

            lblName.Visible = lblCity.Visible = lblRole.Visible = lblDOB.Visible = lblGender.Visible = lblMobile.Visible = lblEmail.Visible = lblPass.Visible = false;
            txtName.Visible = txtCity.Visible = ddlRole.Visible = txtDOB.Visible = ddlGender.Visible = txtMobile.Visible = txtEmail.Visible = txtPass.Visible = lblConPass.Visible = txtConPass.Visible = true;

            ddlRole.SelectedValue = lblRole.Text;
            ddlGender.SelectedValue = lblGender.Text;
        }

        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            DataListItem dli = this.DataListProfile.Controls[this.DataListProfile.Controls.Count - 1] as DataListItem;

            Label lblID = dli.FindControl("lblID") as Label;

            TextBox txtName = dli.FindControl("txtName") as TextBox;
            TextBox txtCity = dli.FindControl("txtCity") as TextBox;
            TextBox txtDOB = dli.FindControl("txtDOB") as TextBox;
            TextBox txtMobile = dli.FindControl("txtMobile") as TextBox;
            TextBox txtEmail = dli.FindControl("txtEmail") as TextBox;
            TextBox txtPass = dli.FindControl("txtPass") as TextBox;
            TextBox txtConPass = dli.FindControl("txtConPass") as TextBox;

            DropDownList ddlRole = dli.FindControl("ddlRole") as DropDownList;
            DropDownList ddlGender = dli.FindControl("ddlGender") as DropDownList;

            String id = lblID.Text;
            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);
            String query = "update Users set " +
                "Name = @Name, " +
                "City = @City, " +
                "Role = @Role, " +
                "DOB = @DOB, " +
                "Gender = @Gender, " +
                "Mobile = @Mobile, " +
                "Email = @Email, " +
                "Password = @Password " +
            " where ID = @ID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("ID", id);
            cmd.Parameters.AddWithValue("Name", txtName.Text);
            cmd.Parameters.AddWithValue("City", txtCity.Text);
            cmd.Parameters.AddWithValue("Role", ddlRole.SelectedValue);
            cmd.Parameters.AddWithValue("DOB", txtDOB.Text);
            cmd.Parameters.AddWithValue("Gender", ddlGender.SelectedValue);
            cmd.Parameters.AddWithValue("Mobile", txtMobile.Text);
            cmd.Parameters.AddWithValue("Email", txtEmail.Text);
            cmd.Parameters.AddWithValue("Password", txtPass.Text);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            lblEmpty.Text = "Profile Updated Successfully";
            lblEmpty.ForeColor = System.Drawing.Color.Green;
            lblEmpty.Visible = true;

            DataListProfile.DataBind();
            SwapLabels();

            btnCancel.Visible = false;
            btnSave.Visible = false;
            btnUpdate.Visible = true;
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        SwapLabels();
        btnCancel.Visible = false;
        btnUpdate.Text = "Edit Profile";

        Response.Redirect(Request.RawUrl);
    }
    public void SwapLabels()
    {
        try
        {
            DataListItem dli = this.DataListProfile.Controls[this.DataListProfile.Controls.Count - 1] as DataListItem;

            Label lblName = dli.FindControl("lblName") as Label;
            Label lblID = dli.FindControl("lblID") as Label;
            Label lblCity = dli.FindControl("lblCity") as Label;
            Label lblRole = dli.FindControl("lblRole") as Label;
            Label lblDOB = dli.FindControl("lblDOB") as Label;
            Label lblGender = dli.FindControl("lblGender") as Label;
            Label lblMobile = dli.FindControl("lblMobile") as Label;
            Label lblEmail = dli.FindControl("lblEmail") as Label;
            Label lblPass = dli.FindControl("lblPass") as Label;
            Label lblConPass = dli.FindControl("lblConPass") as Label;

            TextBox txtName = dli.FindControl("txtName") as TextBox;
            TextBox txtCity = dli.FindControl("txtCity") as TextBox;
            TextBox txtDOB = dli.FindControl("txtDOB") as TextBox;
            TextBox txtMobile = dli.FindControl("txtMobile") as TextBox;
            TextBox txtEmail = dli.FindControl("txtEmail") as TextBox;
            TextBox txtPass = dli.FindControl("txtPass") as TextBox;
            TextBox txtConPass = dli.FindControl("txtConPass") as TextBox;

            DropDownList ddlRole = dli.FindControl("ddlRole") as DropDownList;
            DropDownList ddlGender = dli.FindControl("ddlGender") as DropDownList;

            lblName.Visible = lblCity.Visible = lblRole.Visible = lblDOB.Visible = lblGender.Visible = lblMobile.Visible = lblEmail.Visible = lblPass.Visible = true;
            txtName.Visible = txtCity.Visible = ddlRole.Visible = txtDOB.Visible = ddlGender.Visible = txtMobile.Visible = txtEmail.Visible = txtPass.Visible = lblConPass.Visible = txtConPass.Visible = false;
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }

    protected void DataListProfile_PreRender(object sender, EventArgs e)
    {
        try
        {
            DataListItem dli = this.DataListProfile.Controls[this.DataListProfile.Controls.Count - 1] as DataListItem;

            Label lblPass = dli.FindControl("lblPass") as Label;
            String pass = lblPass.Text;
            String enc = "";
            int passlen = pass.Length;
            for (int i = 0; i < passlen; i++)
            {
                enc += "*";
            }
            lblPass.Text = enc;
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
            String id = Session["ownerid"].ToString();

            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);

            con.Open();

            String hasPG = "select count(*) from PG where OwnerID = @id";
            SqlCommand cmd1 = new SqlCommand(hasPG, con);
            cmd1.Parameters.AddWithValue("id", id);
            int count = Convert.ToInt32(cmd1.ExecuteScalar());

            if (count > 0)
            {
                //For owner --> delete interests for his/her PGs
                String delPGInterests = "delete from Interests where PID in (select ID from PG where OwnerID = @id)";
                SqlCommand cmd5 = new SqlCommand(delPGInterests, con);
                cmd5.Parameters.AddWithValue("id", id);
                cmd5.ExecuteNonQuery();

                String delPG = "delete from PG where OwnerID = @id";
                SqlCommand cmd2 = new SqlCommand(delPG, con);
                cmd2.Parameters.AddWithValue("id", id);
                cmd2.ExecuteNonQuery();

            }

            String delVisit = "delete from SiteVisits where OID = @oid";
            SqlCommand cmd3 = new SqlCommand(delVisit, con);
            cmd3.Parameters.AddWithValue("oid", id);
            cmd3.ExecuteNonQuery();

            String delUser = "delete from Users where ID = @id";
            SqlCommand cmd = new SqlCommand(delUser, con);
            cmd.Parameters.AddWithValue("id", id);
            cmd.ExecuteNonQuery();

            con.Close();

            Session.Abandon();
            Response.Redirect("Home.aspx");
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
}
