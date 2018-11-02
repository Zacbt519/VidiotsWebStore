using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VidiotsWebStore.admin
{
    public partial class UploadImage : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsAdminTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["UserType"].ToString() != "Admin")
            //{
            //    Response.Redirect("../index.aspx");
            //}
            master = (VidiotsAdminTemplate)this.Master;
            if (!IsPostBack)
            {
                imgUploaded.ImageUrl = "";
                imgUploaded.EnableViewState = false;
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            try
            {
                int intSizeLimit = 1048576;

                if (uplPics.HasFile == true)
                {
                    if (uplPics.PostedFile.ContentLength <= intSizeLimit)
                    {
                        string strPath = Server.MapPath("~/tempImg") + "\\" + uplPics.FileName;
                        int extIndex = uplPics.FileName.IndexOf(".");
                        string fileExt = uplPics.FileName.Substring(extIndex, (uplPics.FileName.Length - extIndex));
                        string filename = txtName.Text + fileExt;
                        string url = "~/tempImg/" + filename;

                        string strContentType = uplPics.PostedFile.ContentType;

                        System.Drawing.Image img = System.Drawing.Image.FromStream(uplPics.PostedFile.InputStream);

                        bool imgSaved = false;

                        if (ImageFormat.Jpeg.Equals(img.RawFormat))
                        {
                            imgSaved = doSaveImage(strPath, url, filename);
                            UploadImageToDB(url, filename);
                        }
                        else if (ImageFormat.Gif.Equals(img.RawFormat))
                        {
                            imgSaved = doSaveImage(strPath, url, filename);
                            UploadImageToDB(url, filename);
                        }
                        else if (ImageFormat.Bmp.Equals(img.RawFormat))
                        {
                            imgSaved = doSaveImage(strPath, url, filename);
                            UploadImageToDB(url, filename);
                        }
                        else if (ImageFormat.Png.Equals(img.RawFormat))
                        {
                            imgSaved = doSaveImage(strPath, url, filename);
                            UploadImageToDB(url, filename);
                        }
                        else if (ImageFormat.Tiff.Equals(img.RawFormat))
                        {
                            imgSaved = doSaveImage(strPath, url, filename);
                            UploadImageToDB(url, filename);
                        }
                        else
                        {
                            master.masterMessage = "Not a valid image";
                        }
                    }
                    else
                    {
                        master.masterMessage = "File is too big - please try again";
                    }
                }
            }
            catch (Exception ex)
            {
                if (ex.Message.ToLower() == "parameter is not valid.")
                {
                    master.masterMessage = "Image is not valid.";
                }
                else
                {
                    master.masterMessage = ex.Message;
                }
            }
        }

        private void UploadImageToDB(string strPath, string filename)
        {
            string alt = txtAlt.Text;
            string name = txtName.Text;
            SqlCommand cmd = default(SqlCommand);
            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spUploadImage", conn);
                    cmd.Parameters.AddWithValue("@ImageURL", strPath);
                    cmd.Parameters.AddWithValue("@AltText", txtAlt.Text);

                    cmd.Parameters.AddWithValue("@AdminIDUpload", Session["AdminID"].ToString());
                    cmd.Parameters.AddWithValue("@FileName", filename);

                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    master.masterMessage = "Image uploaded!";
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
        }

        private bool doSaveImage(string strPath, string url, string filename)
        {
            try
            {
                uplPics.SaveAs(strPath);
                master.masterMessage = "Image saved to: " + url;
                imgUploaded.ImageUrl = url;
                imgUploaded.EnableViewState = true;
                File.Move(Server.MapPath("~/tempImg/" + uplPics.FileName), Server.MapPath("~/tempImg/" + filename));
                return true;
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
                return false;
            }
        }
    }
}