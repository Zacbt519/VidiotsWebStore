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

namespace VidiotsWebStore.admin
{
    public partial class UpdateImage : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsAdminTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsAdminTemplate)this.Master;
            if (!IsPostBack)
            {
                ddlImages.DataTextField = "ImageURL";
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
            imgPreview.ImageUrl = ddlImages.SelectedItem.ToString();
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
                    txtFileName.Text = dr["FileName"].ToString();
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
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                FillComboBox();
            }
        }
    }
}