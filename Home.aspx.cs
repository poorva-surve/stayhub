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
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user"] != null)
        {
            lblUser.Text = "Hello, " + Session["user"].ToString();
        }
        else
            lblUser.Text = "Hello, Guest!";

        
    }
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> SearchCity(string prefixText)
    {
        String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
        SqlConnection con = new SqlConnection(myConn);
        SqlDataAdapter da;
        DataTable dt;
        DataTable Result = new DataTable();
        string str = "select CityName from Cities where CityName like '" + prefixText + "%'";

        da = new SqlDataAdapter(str, con);
        dt = new DataTable();
        da.Fill(dt);
        List<string> Output = new List<string>();
        for (int i = 0; i < dt.Rows.Count; i++)
            Output.Add(dt.Rows[i][0].ToString());

        con.Close();
        return Output;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        btnSearch.ValidationGroup = "searchCity";
        String cityName = txtCity.Text;
        Response.Redirect("SeekPG.aspx?city=" + cityName);
    }
}