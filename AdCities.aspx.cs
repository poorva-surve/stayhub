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
        addStatus.Visible = false;
    }
    protected void btnAddCity_Click(object sender, EventArgs e)
    {

        addStatus.Visible = true;
        SqlDataSourceCities.InsertParameters["CityID"].DefaultValue = txtID.Text;
        SqlDataSourceCities.InsertParameters["CityName"].DefaultValue = txtName.Text;
        SqlDataSourceCities.InsertParameters["CityImg"].DefaultValue = txtImg.Text;

        try
        {
            SqlDataSourceCities.Insert();
            addStatus.Text = "City added successfully";
            addStatus.ForeColor = System.Drawing.Color.Green;
        }
        catch
        {
            addStatus.Text = "Failed to insert city. Please try again!";
            addStatus.ForeColor = System.Drawing.Color.Red;
        }
        txtID.Text = txtName.Text = txtImg.Text = "";
    }

    
}