using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminSite : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["admin"] != null)
        {
            //lblUser.Text = Session["admin"].ToString();
            btnLog.Text = "Logout";
        }
        else
        {
            Response.Redirect("Home.aspx");
        }
    }
    protected void btnLog_Click(object sender, EventArgs e)
    {
        if (btnLog.Text == "Logout")
        {
            Session.RemoveAll();
            Session.Abandon();
            Response.Redirect("Home.aspx");
        }
        else
        {
            btnLog.Text = "Login";
            Response.Redirect("Login.aspx");
        }
    }
}
