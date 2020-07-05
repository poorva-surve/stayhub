using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

public partial class _Default : System.Web.UI.Page
{
    String PG_ID="";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
                SqlConnection con = new SqlConnection(myConn);
                String getCity = "select CityName from Cities";
                SqlCommand cmd = new SqlCommand(getCity, con);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    ddlCity.Items.Add(reader[0].ToString());
                }
                con.Close();
            }
            pic1Validation.Visible = pic2Validation.Visible = pic3Validation.Visible = pic4Validation.Visible = pic5Validation.Visible = false;
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }



    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            btnAdd.ValidationGroup = "save";
            if (Session["ownerid"] != null)
            {
                int i = SavePG();
                if (i != 1)
                {
                    lblAddStatus.Text = "Could not add PG. Please Try Again!";
                    lblAddStatus.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    lblAddStatus.Text = "PG Submitted Successfully!";
                    lblAddStatus.ForeColor = System.Drawing.Color.Green;
                    //clearData();
                }
            }
            else
            {
                lblAddStatus.Text = "You need to login first!";
                lblAddStatus.ForeColor = System.Drawing.Color.Red;
            }
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }



    public String generatePGId()
    {
        try
        {
            String pass = "01234567890123456789";
            Random r = new Random();
            char[] mypass = new char[5];
            for (int i = 0; i < 5; i++)
            {
                mypass[i] = pass[(int)(7 * r.NextDouble())];

            }
            String userid = "PG" + new string(mypass);
            return userid;
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
            return null;
        }
    }



    public String validateImages(FileUpload imgFile,Label imgErr,String id)
    {
        try
        {
            if (imgFile.HasFile)
            {
                string fileExtension = System.IO.Path.GetExtension(imgFile.FileName);
                if (fileExtension.ToLower() != ".jpg" && fileExtension.ToLower() != ".jpeg" && fileExtension.ToLower() != ".png" && fileExtension.ToLower() != ".bmp" && fileExtension.ToLower() != ".jfif")
                {
                    imgErr.Visible = true;
                    imgErr.Text = "Only images of .jpg, .jpeg, .png, .bmp, .jfif extensions are allowed";
                }
                else
                {
                    int fileSize = imgFile.PostedFile.ContentLength;
                    if (fileSize > 2097152)
                    {
                        imgErr.Visible = true;
                        imgErr.Text = "Maximum file size (2 MB) exceeded";
                    }
                    else
                    {
                        string createFolder = Server.MapPath(string.Format("~/Images/PGUploads/{0}/", id));
                        if (!Directory.Exists(createFolder))
                        {
                            Directory.CreateDirectory(createFolder);
                        }
                        imgFile.PostedFile.SaveAs(createFolder + imgFile.FileName);
                        String f = "~/Images/PGUploads/" + id + "/" + imgFile.FileName;
                        return f;
                    }
                }
                return "none";
            }
            return "";
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
            return "none";
        }
    }



    public int SavePG()
    {
        try
        {
            String occupancyValues = "";
            String selectedItems = String.Join(",&nbsp;", chkOccupancy.Items.OfType<ListItem>().Where(r => r.Selected).Select(r => r.Value));
            occupancyValues = selectedItems;



            String owner = Session["ownerid"].ToString();
            String name = txtName.Text;
            String addr = txtAddr.Text;
            String city = ddlCity.SelectedItem.Text;
            String rent = txtRent.Text;
            String occ = occupancyValues;

            PG_ID = generatePGId();
            String pic1 = validateImages(FilePic1, pic1Validation, PG_ID);
            String pic2 = validateImages(FilePic2, pic2Validation, PG_ID);
            String pic3 = validateImages(FilePic3, pic3Validation, PG_ID);
            String pic4 = validateImages(FilePic4, pic4Validation, PG_ID);
            String pic5 = validateImages(FilePic5, pic5Validation, PG_ID);
            if (pic1 == "none" || pic2 == "none" || pic3 == "none" || pic4 == "none" || pic5 == "none")
                return 0;
            String meals = rdMealsProvision.SelectedValue;
            String nonv = rdNonvegAllowance.SelectedValue;
            String elec = rdElec.SelectedValue;
            String ac = rdAc.SelectedValue;
            String tv = rdTv.SelectedValue;
            String wifi = rdWifi.SelectedValue;
            String wash = rdWashing.SelectedValue;
            String geys = rdGeyser.SelectedValue;
            String fri = rdFridge.SelectedValue;
            String gas = rdGas.SelectedValue;
            String furn = rdFurnished.SelectedValue;
            String tbl = rdTable.SelectedValue;
            String balc = rdBalcony.SelectedValue;
            String park = rdParking.SelectedValue;
            String sec = rdSecurity.SelectedValue;

            if (Page.IsValid)
            {
                String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
                SqlConnection con = new SqlConnection(myConn);
                String addUser = "insert into PG (ID,OwnerID,Name,Address,City,Rent,Occupancy,Pic1,Pic2,Pic3,Pic4,Pic5,Meals,NonVeg," +
                    "Electricity,AC,TV,WiFi,Laundry,Geyser,Refrigerator,CookingStove,Furnished,StudyTable,Balcony,Parking,Security)" +
                "values (" +
                "@ID, @OwnerID, @Name, @Addr, @City, @Rent, @Occ, @p1, @p2, @p3, @p4, @p5, @Meals, @nonv, " +
                "@elec, @ac, @tv, @wifi, @wash, @geys, @fri, @gas, @furn, @tbl, @balc, @park, @sec)";
                SqlCommand cmd = new SqlCommand(addUser, con);

                cmd.Parameters.AddWithValue("ID", PG_ID);
                cmd.Parameters.AddWithValue("OwnerID", owner);
                cmd.Parameters.AddWithValue("Name", name);
                cmd.Parameters.AddWithValue("Addr", addr);
                cmd.Parameters.AddWithValue("City", city);
                cmd.Parameters.AddWithValue("Rent", rent);
                cmd.Parameters.AddWithValue("Occ", occ);
                cmd.Parameters.AddWithValue("p1", pic1);
                cmd.Parameters.AddWithValue("p2", pic2);
                cmd.Parameters.AddWithValue("p3", pic3);
                cmd.Parameters.AddWithValue("p4", pic4);
                cmd.Parameters.AddWithValue("p5", pic5);
                cmd.Parameters.AddWithValue("Meals", meals);
                cmd.Parameters.AddWithValue("nonv", nonv);
                cmd.Parameters.AddWithValue("elec", elec);
                cmd.Parameters.AddWithValue("ac", ac);
                cmd.Parameters.AddWithValue("tv", tv);
                cmd.Parameters.AddWithValue("wifi", wifi);
                cmd.Parameters.AddWithValue("wash", wash);
                cmd.Parameters.AddWithValue("geys", geys);
                cmd.Parameters.AddWithValue("fri", fri);
                cmd.Parameters.AddWithValue("gas", gas);
                cmd.Parameters.AddWithValue("furn", furn);
                cmd.Parameters.AddWithValue("tbl", tbl);
                cmd.Parameters.AddWithValue("balc", balc);
                cmd.Parameters.AddWithValue("park", park);
                cmd.Parameters.AddWithValue("sec", sec);


                con.Open();
                int i = cmd.ExecuteNonQuery();
                con.Close();
                if (i > 0)
                    return 1;
                else
                    return 0;
            }
            else
                return 0;
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
            return 0;
        }
        
    }

    /*public void clearData()
    {
        foreach (Control c in this.Controls)
        {
            if (c.GetType() == typeof(TextBox))
            {
               ((TextBox)c).Text = string.Empty;
            }
            else if (c is CheckBox)
            {
                ((CheckBox)c).Checked = false;
            }
            else if (c is RadioButton)
            {
                ((RadioButton)c).Checked = false;
            }
        }
    }*/
}