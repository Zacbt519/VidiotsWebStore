using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VidiotsWebStore.admin
{
    public partial class VerifyImages : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        private string uploadedBy;
        VidiotsAdminTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"].ToString() != "Admin")
            {
                Response.Redirect("../index.aspx");
            }
            master = (VidiotsAdminTemplate)this.Master;
            if (!IsPostBack)
            {
                img.ImageUrl = "";
                img.EnableViewState = false;
                ddlImageName.DataTextField = "FileName";
                ddlImageName.DataValueField = "ImageID";
                GetImageURLs();
            }
        }

        protected void GetImageURLs()
        {
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);
            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spGetImagesToVerify", conn);
                    conn.Open();

                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

                    if (dr.HasRows)
                    {
                        ddlImageName.DataSource = dr;
                        ddlImageName.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            finally
            {
                dr.Close();
            }
        }

        protected void ddlImageName_SelectedIndexChanged1(object sender, EventArgs e)
        {
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);
            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spGetImageDetails", conn);
                    cmd.Parameters.AddWithValue("@ImageID", int.Parse(ddlImageName.SelectedValue));
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();

                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

                    if (dr.HasRows)
                    {
                        dr.Read();
                        txtName.Text = dr["FileName"].ToString();
                        txtAlt.Text = dr["AltText"].ToString();
                        Session["filename"] = dr["FileName"].ToString();
                        Session["oldUrl"] = dr["ImageURL"].ToString();
                        img.ImageUrl = dr["ImageURL"].ToString();
                        img.EnableViewState = true;
                        uploadedBy = dr["AdminIDUpload"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            finally
            {
                dr.Close();
            }
        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            string oldUrl = Session["oldUrl"].ToString();
            string oldFull = Server.MapPath("~/tempImg") + oldUrl.Substring(1, (oldUrl.Length - 1)); 
            string file = oldUrl.Substring(10, (oldUrl.Length - 10));
            string newUrl = Server.MapPath("~/img") + file;

            try
            {
                System.IO.File.Move(oldFull, newUrl);
                SqlCommand cmd = default(SqlCommand);
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    if(uploadedBy != Session["AdminID"].ToString())
                    {
                        cmd = new SqlCommand("spVerifyImage", conn);
                        cmd.Parameters.AddWithValue("@ImageID", int.Parse(ddlImageName.SelectedValue));
                        cmd.Parameters.AddWithValue("@ImageURL", newUrl);
                        cmd.CommandType = CommandType.StoredProcedure;
                        conn.Open();

                        cmd.ExecuteNonQuery();

                        ddlImageName.DataSource = null;
                        ddlImageName.DataBind();
                        ddlImageName.Items.Clear();
                        GetImageURLs();
                        img.ImageUrl = "";
                        img.EnableViewState = false;
                        txtAlt.Text = "";
                        txtName.Text = "";
                        master.masterMessage = "Image verified";
                    }
                    else
                    {
                        master.masterMessage = "Image cannot be verified by the same user that uploaded it.";
                    }
                }
            }
            catch(Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            
        }
    }
}