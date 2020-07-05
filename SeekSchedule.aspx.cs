using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userid"] == null)
        {
            Response.Redirect("Login.aspx");
        }
    }

    protected void GridViewSchedule_PreRender(object sender, EventArgs e)
    {
        try
        {
            String year = DateTime.Today.Year.ToString();
            String month = DateTime.Today.Month.ToString();
            String day = DateTime.Today.Day.ToString();
            String fulldate = year + "-" + month + "-" + day;

            SqlDataSourceVisits.SelectParameters["today"].DefaultValue = fulldate;

            if (GridViewSchedule.Rows.Count == 0)
            {
                GridViewSchedule.Visible = false;
                upcomingStatus.Style.Add("display", "block");
            }
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }


    protected void GridViewPending_PreRender(object sender, EventArgs e)
    {
        try
        {
            if (GridViewPending.Rows.Count == 0)
            {
                GridViewPending.Visible = false;
                pendingStatus.Style.Add("display", "block");
            }
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }

    protected void GridViewPast_PreRender(object sender, EventArgs e)
    {
        try
        {
            String year = DateTime.Today.Year.ToString();
            String month = DateTime.Today.Month.ToString();
            String day = DateTime.Today.Day.ToString();
            String fulldate = year + "-" + month + "-" + day;

            SqlDataSourcePast.SelectParameters["today"].DefaultValue = fulldate;
            if (GridViewPast.Rows.Count == 0)
            {
                GridViewPast.Visible = false;
                pastStatus.Style.Add("display", "block");
            }
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }

    protected void GridViewPending_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            TableCell pgName = GridViewPending.Rows[e.RowIndex].Cells[0];
            TableCell pgAddr = GridViewPending.Rows[e.RowIndex].Cells[1];

            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);

            String pgID = "";
            String getPG = "select ID from PG where (Name = @name and Address = @addr)";
            SqlCommand cmd1 = new SqlCommand(getPG, con);
            cmd1.Parameters.AddWithValue("name", pgName.Text);
            cmd1.Parameters.AddWithValue("addr", pgAddr.Text);

            con.Open();
            SqlDataReader reader = cmd1.ExecuteReader();
            while (reader.Read())
            {
                pgID = reader[0].ToString();
            }
            con.Close();

            SqlDataSourcePendingVisits.DeleteParameters["PID"].DefaultValue = pgID;

        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
}