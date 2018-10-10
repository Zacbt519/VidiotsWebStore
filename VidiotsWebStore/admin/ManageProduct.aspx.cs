using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace VidiotsWebStore
{
    public partial class ManageProduct : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsAdminTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsAdminTemplate)this.Master;
            string productId = Request.QueryString["productId"];
            if (!IsPostBack)
            {
                ddlImageURL.DataTextField = "ImageURL";
                ddlImageURL.DataValueField = "ImageID";
                GetImageURLs();
                ddlProductType.DataTextField = "Name";
                ddlProductType.DataValueField = "TypeID";
                GetProductTypes();
                ddlCategoryID.DataTextField = "Name";
                ddlCategoryID.DataValueField = "CategoryID";
                GetCategoryIDs();
                ddlProductStatus.DataTextField = "StatusDescription";
                ddlProductStatus.DataValueField = "StatusID";
                GetProductStatuses();
                if (!string.IsNullOrEmpty(productId))
                {
                    GetProduct(productId);
                }
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
                    cmd = new SqlCommand("spGetImageURL", conn);
                    conn.Open();

                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

                    if (dr.HasRows)
                    {
                        ddlImageURL.DataSource = dr;
                        ddlImageURL.DataBind();
                        dr.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = "Unable to Retrieve Image URLs. Error: " + ex.Message;
            }
        }

        protected void GetProductTypes()
        {
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);

            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spGetProductType", conn);
                    conn.Open();

                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

                    if (dr.HasRows)
                    {
                        ddlProductType.DataSource = dr;
                        ddlProductType.DataBind();
                        dr.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            
        }

        protected void GetProduct(string productId)
        {
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);

            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spGetAllProductInfoByID @ID = " + productId, conn);
                    conn.Open();
                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

                    if (dr.HasRows)
                    {
                        dr.Read();
                        productImage.ImageUrl = dr["ImageURL"].ToString();
                        txtProductName.Text = dr["ProductName"].ToString();
                        txtBriefDescription.Text = dr["BriefDescription"].ToString();
                        txtFullDescription.Text = dr["FullDescription"].ToString();
                        txtPrice.Text = dr["Price"].ToString();
                        chkFeatured.Checked = (bool)dr["Featured"];
                        dr.Close();
                        
                        
                    }
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string productId = Request.QueryString["productId"];
            if (!string.IsNullOrEmpty(productId))
            {
                UpdateProduct(productId);
            }
        }

        private void UpdateProduct(string productId)
        {
            SqlCommand cmd = default(SqlCommand);

            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spUpdateProduct", conn);
                    cmd.Parameters.AddWithValue("@ProductID", productId);
                    cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text);
                    cmd.Parameters.AddWithValue("@BriefDescription", txtBriefDescription.Text);
                    cmd.Parameters.AddWithValue("@FullDescription", txtFullDescription.Text);
                    cmd.Parameters.AddWithValue("@Price", txtPrice.Text);
                    cmd.Parameters.AddWithValue("@ImageID", ddlImageURL.SelectedValue);
                    cmd.Parameters.AddWithValue("@Featured", chkFeatured.Checked);
                    cmd.Parameters.AddWithValue("@ProductStatus", ddlProductStatus.SelectedValue);
                    cmd.Parameters.AddWithValue("@CategoryID", ddlCategoryID.SelectedValue);
                    cmd.Parameters.AddWithValue("@ProductType", ddlProductType.SelectedValue);
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }

            finally
            {
                master.masterMessage = "Product updated";
            }
            

        }

        protected void GetCategoryIDs()
        {
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);

            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spGetAllCategoryID", conn);
                    conn.Open();

                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

                    if (dr.HasRows)
                    {
                        ddlCategoryID.DataSource = dr;
                        ddlCategoryID.DataBind();
                        dr.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            
        }

        protected void GetProductStatuses()
        {
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);

            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spGetAllProductStatus", conn);
                    conn.Open();

                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

                    if (dr.HasRows)
                    {
                        ddlProductStatus.DataSource = dr;
                        ddlProductStatus.DataBind();
                        dr.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
           
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            master = (VidiotsAdminTemplate)this.Master;

            btnDelete.Visible = false;
            btnConfirmYes.Visible = true;
            btnConfirmNo.Visible = true;
            lblAreYouSure.Visible = true;

            

        }

        protected void btnConfirmYes_Click(object sender, EventArgs e)
        {
            master = (VidiotsAdminTemplate)this.Master;

            SqlCommand cmd = default(SqlCommand);

            string productId = Request.QueryString["productId"];
            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spDeleteProduct");
                    cmd.Parameters.AddWithValue("@ProductID", productId);
                    cmd.Connection = conn;
                    conn.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                    master.masterMessage = "Product Deleted";

                }

            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            finally
            {
                btnConfirmYes.Visible = false;
                btnConfirmNo.Visible = false;
                btnDelete.Visible = true;
                lblAreYouSure.Visible = false;
            }
        }

        protected void btnConfirmNo_Click(object sender, EventArgs e)
        {
            btnConfirmNo.Visible = false;
            btnConfirmYes.Visible = false;
            btnDelete.Visible = true;
            lblAreYouSure.Visible = false;
        }
    }
}