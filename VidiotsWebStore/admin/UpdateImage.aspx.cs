using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.Sql;
using System.IO;
using System.Drawing.Imaging;

namespace VidiotsWebStore.admin
{
    public partial class UpdateImage : System.Web.UI.Page
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
                ddlImages.DataTextField = "FileName";
                ddlImages.DataValueField = "ImageID";
                FillComboBox();
                ddlImages.Items.Insert(0, "---Select an Image---");
                ddlImages.SelectedIndex = 0;
                
            }
            
        }

        private void FillComboBox()
        {
            SqlDataReader dr = default(SqlDataReader);
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                SqlCommand cmd = new SqlCommand("spGetImageURL", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection.Open();
                dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                if (dr.HasRows)
                {
                    ddlImages.DataSource = dr;
                    ddlImages.DataBind();
                }
            }
        }

        protected void ddlImages_SelectedIndexChanged(object sender, EventArgs e)
        {
            master.masterMessage = "";
            GetImageData(ddlImages.SelectedValue);
        }

        private void GetImageData(string selectedValue)
        {
            SqlDataReader dr = default(SqlDataReader);
            using(SqlConnection conn = new SqlConnection(strConn))
            {
                SqlCommand cmd = new SqlCommand("spGetImageInfoByID", conn);
                cmd.Parameters.Add(new SqlParameter("@ImageID", int.Parse(selectedValue)));
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection.Open();
                dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                if (dr.HasRows)
                {
                    dr.Read();
                    txtAltText.Text = dr["AltText"].ToString();
                    int extIndex = dr["FileName"].ToString().IndexOf(".");
                    string fullExt = dr["FileName"].ToString().Substring(extIndex, (dr["FileName"].ToString().Length - extIndex));
                    int extLength = fullExt.Length;
                    string filename = dr["FileName"].ToString().Substring(0, (dr["FileName"].ToString().Length - extLength));
                    txtFileName.Text = filename;
                    imgPreview.ImageUrl = dr["ImageURL"].ToString();
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (ddlImages.SelectedIndex == 0 || ddlImages.SelectedIndex == -1)
            {
                master.masterMessage = "You must select an image to Update";
            }
            else
            {
                System.Drawing.Image image = System.Drawing.Image.FromFile(Server.MapPath("~/img/" + ddlImages.SelectedItem.Text));

                if (ImageFormat.Jpeg.Equals(image.RawFormat))
                {
                    image.Dispose();
                    UpdateImageInfo(ddlImages.SelectedValue, ".jpg");
                }
                else if (ImageFormat.Bmp.Equals(image.RawFormat))
                {
                    image.Dispose();
                    UpdateImageInfo(ddlImages.SelectedValue, ".bmp");
                }
                else if (ImageFormat.Gif.Equals(image.RawFormat))
                {
                    image.Dispose();
                    UpdateImageInfo(ddlImages.SelectedValue, ".gif");
                }
                else if (ImageFormat.Icon.Equals(image.RawFormat))
                {
                    image.Dispose();
                    UpdateImageInfo(ddlImages.SelectedValue, ".ico");
                }
                else if (ImageFormat.Png.Equals(image.RawFormat))
                {
                    image.Dispose();
                    UpdateImageInfo(ddlImages.SelectedValue, ".png");
                }
                else if (ImageFormat.Tiff.Equals(image.RawFormat))
                {
                    image.Dispose();
                    UpdateImageInfo(ddlImages.SelectedValue, ".tiff");
                }
                else
                {
                    image.Dispose();
                    master.masterMessage = "File type is not accpeted";
                }

            }
        }

        private void UpdateImageInfo(string imgID, string fileType)
        {
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                SqlCommand cmd = new SqlCommand("spUpdateImageInfo", conn);
                cmd.Parameters.Add(new SqlParameter("@ImageID", int.Parse(imgID)));
                int extIndex = ddlImages.SelectedItem.ToString().IndexOf(".");
                string ext = ddlImages.SelectedItem.ToString().Substring(extIndex, (ddlImages.SelectedItem.ToString().Length - extIndex));
                cmd.Parameters.Add(new SqlParameter("@FileName", txtFileName.Text + ext));
                cmd.Parameters.Add(new SqlParameter("@AltText", txtAltText.Text));
                cmd.Parameters.Add(new SqlParameter("@ImageURL", "~/img/" + txtFileName.Text + fileType));
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection.Open();

                cmd.ExecuteNonQuery();

                cmd.Connection.Close();
                
                File.Move(Server.MapPath("../img/" + ddlImages.SelectedItem.Text), Server.MapPath("../img/" + txtFileName.Text + fileType));
                master.masterMessage = "Image update successfully";
                ddlImages.DataSource = null;
                ddlImages.DataBind();
                FillComboBox();
                RefreshFolder();
                ddlImages.Items.Insert(0, "---Select an Image---");
                imgPreview.ImageUrl = "";
                txtAltText.Text = "";
                txtFileName.Text = "";
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (ddlImages.SelectedIndex == 0 || ddlImages.SelectedIndex == -1)
            {
                master.masterMessage = "You must select an image to delete";
            }
            else
            {
                areYouSure.Visible = true;
            }
            
        }

        protected void btnNo_Click(object sender, EventArgs e)
        {
            areYouSure.Visible = false;
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            if(CheckForImage(ddlImages.SelectedValue) == false)
            {
                DeleteImage(ddlImages.SelectedValue);
            }
            else
            {
                master.masterMessage = "There are products on the database with this image. You must disassociate them before you can delete the image!";
            }
            
        }

        private bool CheckForImage(string selectedValue)
        {
            SqlDataReader dr = default(SqlDataReader);
            using(SqlConnection conn = new SqlConnection(strConn))
            {
                SqlCommand cmd = new SqlCommand("spCheckForImage", conn);
                cmd.Parameters.Add(new SqlParameter("@ImageID", int.Parse(selectedValue)));
                SqlParameter output = new SqlParameter("@ProductCount", SqlDbType.Int);
                output.Direction = ParameterDirection.Output;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(output);
                cmd.Connection.Open();

                dr = cmd.ExecuteReader();
                dr.Close();
                if(VerifyRecords(output) == false)
                {
                    return false;
                }
                else
                {
                    return true;
                }
                
            }
        }

        private bool VerifyRecords(SqlParameter output)
        {
            int results = int.Parse(output.Value.ToString());

            if (results == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        private void DeleteImage(string selectedValue)
        {
            using(SqlConnection conn = new SqlConnection(strConn))
            {
                SqlCommand cmd = new SqlCommand("spDeleteImageByID", conn);
                cmd.Parameters.Add(new SqlParameter("@ImageID", int.Parse(selectedValue)));
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter output = new SqlParameter("@ImagePath", SqlDbType.VarChar, 50);
                output.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(output);
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                FillComboBox();
                File.Delete(Server.MapPath(output.Value.ToString()));
                   
            }
        }

        private void RefreshFolder()
        {
            if (Directory.Exists(Server.MapPath("/img")))
            {
                Directory.GetFiles(Server.MapPath("/img"));

                DirectoryInfo dir = new DirectoryInfo(Server.MapPath("/img"));
                dir.Refresh();
            }
        }
    }
}