using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VidiotsWebStore
{
    public partial class AddProduct : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
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
                ddlImageURL.DataTextField = "ImageURL";
                ddlImageURL.DataValueField = "ImageID";
                GetImageURLs();
                ddlProductType.DataTextField = "Name";
                ddlProductType.DataValueField = "TypeID";
                GetProductTypes();
                ddlProductStatus.DataTextField = "StatusDescription";
                ddlProductStatus.DataValueField = "StatusID";
                GetProductStatuses();
                ddlCategoryID.DataTextField = "Name";
                ddlCategoryID.DataValueField = "CategoryID";
                GetCategoryIDs();
            }

            if (IsPostBack)
            {
                master.masterMessage = "";
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
                    }
                    else
                    {
                        
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
                    }
                    else
                    {

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

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            InsertProduct();
        }

        private void InsertProduct()
        {
            SqlCommand cmd = default(SqlCommand);

            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spInsertProduct", conn);
                    cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text);
                    cmd.Parameters.AddWithValue("@BriefDescription", txtBriefDescription.Text);
                    cmd.Parameters.AddWithValue("@FullDescription", txtFullDescription.Text);
                    cmd.Parameters.AddWithValue("@Price", txtPrice.Text);
                    cmd.Parameters.AddWithValue("@ImageID", ddlImageURL.SelectedValue);
                    cmd.Parameters.AddWithValue("@Featured", chkFeatured.Checked);
                    cmd.Parameters.AddWithValue("@ProductStatus", ddlProductStatus.SelectedValue);
                    cmd.Parameters.AddWithValue("@CategoryID", ddlCategoryID.SelectedValue);
                    cmd.Parameters.AddWithValue("@Type", ddlProductType.SelectedValue);
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    master.masterMessage = "Product added";

                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            finally
            {

            }

        }

        protected void GetProductTypeID()
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
    }
}