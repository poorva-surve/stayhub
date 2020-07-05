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
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["owner"] == null)
            Response.Redirect("Home.aspx");

        
    }


    protected void DataListFullPG_PreRender(object sender, EventArgs e)
    {
        try
        {
            Label lblExp = (Label)DataListFullPG.Items[0].FindControl("lblExp");
            String exp = lblExp.Text;

            if (exp == "01-01-1900")
                lblExp.Text = "Unapproved";


            Label pid;
            String pgid = "";

            /*Retrieving PG ID - used for where condition in db retrieval */
            pid = (Label)DataListFullPG.Items[0].FindControl("lblID");
            pgid = pid.Text;

            /*Displaying available & unavailable amenities*/
            Dictionary<string, string> dictAmenities = new Dictionary<string, string>();
            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);
            String getAmenities = "select Electricity, AC, TV, WiFi, Laundry, Geyser, Refrigerator, CookingStove," +
            " StudyTable, Balcony, Parking, Security, Meals, NonVeg from PG where ID = @pid;";
            SqlCommand cmd = new SqlCommand(getAmenities, con);
            cmd.Parameters.AddWithValue("pid", pgid);
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                dictAmenities.Add("Electricity", reader[0].ToString());
                dictAmenities.Add("AC", reader[1].ToString());
                dictAmenities.Add("Television", reader[2].ToString());
                dictAmenities.Add("WiFi", reader[3].ToString());
                dictAmenities.Add("Laundry", reader[4].ToString());
                dictAmenities.Add("Geyser", reader[5].ToString());
                dictAmenities.Add("Fridge", reader[6].ToString());
                dictAmenities.Add("Cooking Stove", reader[7].ToString());
                dictAmenities.Add("Study Table", reader[8].ToString());
                dictAmenities.Add("Balcony", reader[9].ToString());
                dictAmenities.Add("Parking", reader[10].ToString());
                dictAmenities.Add("Security", reader[11].ToString());
                dictAmenities.Add("Meals", reader[12].ToString());
                dictAmenities.Add("Non-Veg", reader[13].ToString());
            }
            con.Close();

            Label lblAvailable = (Label)DataListFullPG.Items[0].FindControl("lblAvailableAmn");
            Label lblUnavailable = (Label)DataListFullPG.Items[0].FindControl("lblUnavailableAmn");
            lblAvailable.Text = lblUnavailable.Text = "";

            foreach (KeyValuePair<string, string> amn in dictAmenities)
            {
                if (amn.Value == "Yes" || amn.Value == "Provided" || amn.Value == "Allowed")
                {
                    lblAvailable.Text += "<strong>" + amn.Key + ": </strong>" + amn.Value + "<br>";
                }
                if (amn.Value == "No" || amn.Value == "Not Provided" || amn.Value == "Not Allowed")
                {
                    lblUnavailable.Text += "<strong>" + amn.Key + ": </strong>" + amn.Value + "<br>";
                }
            }
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }


    protected void deletePG_Click(object sender, EventArgs e)
    {
        /*
        String pgid = Request.QueryString["id"];
        string path = Server.MapPath(string.Format("~/Images/PGUploads/{0}/", pgid));
        if (Directory.Exists(path))
        {
            DeleteDirectory(path);
        }
         * */
        try
        {
            String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
            SqlConnection con = new SqlConnection(myConn);
            String delPG = "delete from PG where ID = @id";
            SqlCommand cmd = new SqlCommand(delPG, con);
            cmd.Parameters.AddWithValue("id", Request.QueryString["id"]);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            DataListFullPG.Visible = false;
            deletePG.Visible = false;
            lblEmpty.Text = "PG Removed Successfully";
            lblEmpty.ForeColor = System.Drawing.Color.Red;
            lblEmpty.Visible = true;
            btnUpdate.Visible = false;
            btnCancel.Visible = false;
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
    /*
    private void DeleteDirectory(string path)
    {
        // Delete all files from the Directory
        foreach (string filename in Directory.GetFiles(path))
        {
            File.Delete(filename);
        }
        Directory.Delete(path);
    }
    */
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            lblEmpty.Visible = false;
            btnCancel.Visible = true;
            deletePG.Visible = false;
            DataListItem dli = this.DataListFullPG.Controls[this.DataListFullPG.Controls.Count - 1] as DataListItem;

            /*Editable amenities list*/
            Label l1 = dli.FindControl("lblName") as Label;
            TextBox t1 = dli.FindControl("txtName") as TextBox;

            Label l2 = dli.FindControl("lblAddr") as Label;
            TextBox t2 = dli.FindControl("txtAddr") as TextBox;

            Label l3 = dli.FindControl("lblOcc") as Label;
            TextBox t3 = dli.FindControl("txtOcc") as TextBox;

            Label l4 = dli.FindControl("lblRent") as Label;
            TextBox t4 = dli.FindControl("txtRent") as TextBox;

            Label l5 = dli.FindControl("lblElec") as Label;
            DropDownList d5 = dli.FindControl("ddlElec") as DropDownList;

            Label l6 = dli.FindControl("lblLndry") as Label;
            DropDownList d6 = dli.FindControl("ddlLndry") as DropDownList;

            Label l7 = dli.FindControl("lblGeyser") as Label;
            DropDownList d7 = dli.FindControl("ddlGeyser") as DropDownList;

            Label l8 = dli.FindControl("lblTV") as Label;
            DropDownList d8 = dli.FindControl("ddlTV") as DropDownList;

            Label l9 = dli.FindControl("lblFri") as Label;
            DropDownList d9 = dli.FindControl("ddlFri") as DropDownList;

            Label l10 = dli.FindControl("lblAC") as Label;
            DropDownList d10 = dli.FindControl("ddlAC") as DropDownList;

            Label l11 = dli.FindControl("lblWi") as Label;
            DropDownList d11 = dli.FindControl("ddlWi") as DropDownList;

            Label l12 = dli.FindControl("lblCook") as Label;
            DropDownList d12 = dli.FindControl("ddlCook") as DropDownList;

            Label l13 = dli.FindControl("lblMeals") as Label;
            DropDownList d13 = dli.FindControl("ddlMeals") as DropDownList;

            Label l14 = dli.FindControl("lblNonV") as Label;
            DropDownList d14 = dli.FindControl("ddlNonV") as DropDownList;

            Label l15 = dli.FindControl("lblTable") as Label;
            DropDownList d15 = dli.FindControl("ddlTable") as DropDownList;

            Label l16 = dli.FindControl("lblBalc") as Label;
            DropDownList d16 = dli.FindControl("ddlBalc") as DropDownList;

            Label l17 = dli.FindControl("lblPark") as Label;
            DropDownList d17 = dli.FindControl("ddlPark") as DropDownList;

            Label l18 = dli.FindControl("lblSec") as Label;
            DropDownList d18 = dli.FindControl("ddlSec") as DropDownList;


            FileUpload f1 = dli.FindControl("FilePic1") as FileUpload;
            FileUpload f2 = dli.FindControl("FilePic2") as FileUpload;
            FileUpload f3 = dli.FindControl("FilePic3") as FileUpload;
            FileUpload f4 = dli.FindControl("FilePic4") as FileUpload;
            FileUpload f5 = dli.FindControl("FilePic5") as FileUpload;
            Label pic1Validation = dli.FindControl("pic1Validation") as Label;
            Label pic2Validation = dli.FindControl("pic2Validation") as Label;
            Label pic3Validation = dli.FindControl("pic3Validation") as Label;
            Label pic4Validation = dli.FindControl("pic4Validation") as Label;
            Label pic5Validation = dli.FindControl("pic5Validation") as Label;


            if (btnUpdate.Text == "Edit PG")        //Owner wants to edit
            {
                btnUpdate.Text = "Save Changes";


                editAmenitiesList.Visible = true;
                editPhotos.Visible = true;
                viewAmenitiesList.Visible = false;
                //viewPhotos.Visible = false;

                l1.Visible = false;
                t1.Visible = true;
                l2.Visible = false;
                t2.Visible = true;
                l3.Visible = false;
                t3.Visible = true;
                l4.Visible = false;
                t4.Visible = true;

                d5.SelectedValue = l5.Text;
                d6.SelectedValue = l6.Text;
                d7.SelectedValue = l7.Text;
                d8.SelectedValue = l8.Text;
                d9.SelectedValue = l9.Text;
                d10.SelectedValue = l10.Text;
                d11.SelectedValue = l11.Text;
                d12.SelectedValue = l12.Text;
                d13.SelectedValue = l13.Text;
                d14.SelectedValue = l14.Text;
                d15.SelectedValue = l15.Text;
                d16.SelectedValue = l16.Text;
                d17.SelectedValue = l17.Text;
                d18.SelectedValue = l18.Text;



                /*Retrieving pictures to display filecontrol only for additional pics instead of overwriting all*/
                String id = Request.QueryString["id"];

                String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
                SqlConnection con = new SqlConnection(myConn);

                String query = "select Pic1, Pic2, Pic3, Pic4, Pic5 from PG where ID = @ID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("ID", id);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    String p1 = reader[0].ToString();
                    String p2 = reader[1].ToString();
                    String p3 = reader[2].ToString();
                    String p4 = reader[3].ToString();
                    String p5 = reader[4].ToString();

                    if (p1 == "")
                        f1.Visible = true;
                    if (p2 == "")
                        f2.Visible = true;
                    if (p3 == "")
                        f3.Visible = true;
                    if (p4 == "")
                        f4.Visible = true;
                    if (p5 == "")
                        f5.Visible = true;
                }
                con.Close();


                //pic1Validation.Visible = pic2Validation.Visible = pic3Validation.Visible = pic4Validation.Visible = pic5Validation.Visible = true;




            }
            else if (btnUpdate.Text == "Save Changes")     //Owner wants to update the details (save changes)
            {

                String id = Request.QueryString["id"];


                String myConn = ConfigurationManager.ConnectionStrings["StayHubDBConnection"].ConnectionString;
                SqlConnection con = new SqlConnection(myConn);


                /*Update textual fields*/
                String query = "update PG set " +
                    "Name = @Name, " +
                    "Address = @Addr, " +
                    "Rent = @Rent, " +
                    "Occupancy = @Occ, " +
                    "Meals = @Meals, " +
                    "NonVeg = @NonV, " +
                    "Electricity = @Elec, " +
                    "AC = @AC, " +
                    "TV = @TV, " +
                    "WiFi = @Wi, " +
                    "Laundry = @Lndry, " +
                    "Geyser = @Geyser, " +
                    "Refrigerator = @Fri, " +
                    "CookingStove = @Cook, " +
                    "StudyTable = @Table, " +
                    "Balcony = @Balc, " +
                    "Parking = @Park, " +
                    "Security = @Sec " +
                " where ID = @ID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("ID", id);
                cmd.Parameters.AddWithValue("Name", t1.Text);
                cmd.Parameters.AddWithValue("Addr", t2.Text);
                cmd.Parameters.AddWithValue("Occ", t3.Text);
                cmd.Parameters.AddWithValue("Rent", t4.Text);
                cmd.Parameters.AddWithValue("Elec", d5.SelectedValue);
                cmd.Parameters.AddWithValue("Lndry", d6.SelectedValue);
                cmd.Parameters.AddWithValue("Geyser", d7.SelectedValue);
                cmd.Parameters.AddWithValue("TV", d8.SelectedValue);
                cmd.Parameters.AddWithValue("Fri", d9.SelectedValue);
                cmd.Parameters.AddWithValue("AC", d10.SelectedValue);
                cmd.Parameters.AddWithValue("Wi", d11.SelectedValue);
                cmd.Parameters.AddWithValue("Cook", d12.SelectedValue);
                cmd.Parameters.AddWithValue("Meals", d13.SelectedValue);
                cmd.Parameters.AddWithValue("NonV", d14.SelectedValue);
                cmd.Parameters.AddWithValue("Table", d15.SelectedValue);
                cmd.Parameters.AddWithValue("Balc", d16.SelectedValue);
                cmd.Parameters.AddWithValue("Park", d17.SelectedValue);
                cmd.Parameters.AddWithValue("Sec", d18.SelectedValue);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();


                /*Update picture fields*/

                if (f1.Visible)
                {
                    String pic1 = validateImages(f1, pic1Validation, id);
                    String picQuery = "update PG set Pic1 = @p where ID = @ID";

                    SqlCommand cmd1 = new SqlCommand(picQuery, con);
                    cmd1.Parameters.AddWithValue("ID", id);
                    cmd1.Parameters.AddWithValue("p", pic1);
                    con.Open();
                    cmd1.ExecuteNonQuery();
                    con.Close();
                }
                if (f2.Visible)
                {
                    String pic2 = validateImages(f2, pic2Validation, id);
                    String picQuery = "update PG set Pic2 = @p where ID = @ID";

                    SqlCommand cmd1 = new SqlCommand(picQuery, con);
                    cmd1.Parameters.AddWithValue("ID", id);
                    cmd1.Parameters.AddWithValue("p", pic2);
                    con.Open();
                    cmd1.ExecuteNonQuery();
                    con.Close();
                }
                if (f3.Visible)
                {
                    String pic3 = validateImages(f3, pic3Validation, id);
                    String picQuery = "update PG set Pic3 = @p where ID = @ID";

                    SqlCommand cmd1 = new SqlCommand(picQuery, con);
                    cmd1.Parameters.AddWithValue("ID", id);
                    cmd1.Parameters.AddWithValue("p", pic3);
                    con.Open();
                    cmd1.ExecuteNonQuery();
                    con.Close();
                }
                if (f4.Visible)
                {
                    String pic4 = validateImages(f4, pic4Validation, id);
                    String picQuery = "update PG set Pic4 = @p where ID = @ID";

                    SqlCommand cmd1 = new SqlCommand(picQuery, con);
                    cmd1.Parameters.AddWithValue("ID", id);
                    cmd1.Parameters.AddWithValue("p", pic4);
                    con.Open();
                    cmd1.ExecuteNonQuery();
                    con.Close();
                }
                if (f5.Visible)
                {
                    String pic5 = validateImages(f5, pic5Validation, id);
                    String picQuery = "update PG set Pic5 = @p where ID = @ID";

                    SqlCommand cmd1 = new SqlCommand(picQuery, con);
                    cmd1.Parameters.AddWithValue("ID", id);
                    cmd1.Parameters.AddWithValue("p", pic5);
                    con.Open();
                    cmd1.ExecuteNonQuery();
                    con.Close();
                }

                lblEmpty.Text = "PG Updated Successfully";
                lblEmpty.ForeColor = System.Drawing.Color.Green;
                lblEmpty.Visible = true;

                DataListFullPG.DataBind();

                btnCancel.Visible = false;
                btnUpdate.Text = "Edit PG";
                deletePG.Visible = true;

                editAmenitiesList.Visible = false;
                editPhotos.Visible = false;
                viewAmenitiesList.Visible = true;
                viewPhotos.Visible = true;
                SwapLabels();
            }
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            SwapLabels();
            btnCancel.Visible = false;
            deletePG.Visible = true;
            btnUpdate.Text = "Edit PG";

            editAmenitiesList.Visible = false;
            editPhotos.Visible = false;
            viewAmenitiesList.Visible = true;
            viewPhotos.Visible = true;
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }

    
    public void SwapLabels()
    {
        try
        {
            DataListItem dli = this.DataListFullPG.Controls[this.DataListFullPG.Controls.Count - 1] as DataListItem;

            Label l1 = dli.FindControl("lblName") as Label;
            TextBox t1 = dli.FindControl("txtName") as TextBox;

            Label l2 = dli.FindControl("lblAddr") as Label;
            TextBox t2 = dli.FindControl("txtAddr") as TextBox;

            Label l3 = dli.FindControl("lblOcc") as Label;
            TextBox t3 = dli.FindControl("txtOcc") as TextBox;

            Label l4 = dli.FindControl("lblRent") as Label;
            TextBox t4 = dli.FindControl("txtRent") as TextBox;


            l1.Visible = true;
            t1.Visible = false;
            l2.Visible = true;
            t2.Visible = false;
            l3.Visible = true;
            t3.Visible = false;
            l4.Visible = true;
            t4.Visible = false;
        }
        catch (Exception exc)
        {
            Response.Redirect("ErrorPage.aspx");
        }
    }


    public String validateImages(FileUpload imgFile, Label imgErr, String id)
    {
        try
        {
            if (imgFile.HasFile)
            {
                string fileExtension = System.IO.Path.GetExtension(imgFile.FileName);
                if (fileExtension.ToLower() != ".jpg" && fileExtension.ToLower() != ".jpeg" && fileExtension.ToLower() != ".png" && fileExtension.ToLower() != ".bmp" && fileExtension.ToLower() != ".jfif")
                {
                    //imgErr.Visible = true;
                    imgErr.Text = "Only images of .jpg, .jpeg, .png, .bmp, .jfif extensions are allowed";
                }
                else
                {
                    int fileSize = imgFile.PostedFile.ContentLength;
                    if (fileSize > 2097152)
                    {
                        //imgErr.Visible = true;
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
            return "";
        }
    }
}