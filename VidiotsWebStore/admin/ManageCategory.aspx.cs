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
    public partial class ManageCategory : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsAdminTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsAdminTemplate)this.Master;
            string categoryId = Request.QueryString["categoryId"];
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(categoryId))
                {
                    GetCategory(categoryId);
                }
            }
        }

        private void GetCategory(string categoryId)
        {
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);

            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spGetCategoryInfo @ID = " + categoryId, conn);
                    conn.Open();
                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

                    if (dr.HasRows)
                    {
                        dr.Read();
                        txtCatName.Text = dr["Name"].ToString();
                        txtCatDesc.Text = dr["Description"].ToString();
                    }
                    else
                    {

                    }
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = "Unable to Retrieve Category. Error: " + ex.Message;
            }
            finally
            {
                dr.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string categoryId = Request.QueryString["categoryId"];
            if (!string.IsNullOrEmpty(categoryId))
            {
                UpdateCategory(categoryId);
            }
        }

        private void UpdateCategory(string categoryId)
        {
            SqlCommand cmd = default(SqlCommand);

            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spUpdateCategory", conn);
                    cmd.Parameters.AddWithValue("@CategoryID", categoryId);
                    cmd.Parameters.AddWithValue("@Name", txtCatName.Text);
                    cmd.Parameters.AddWithValue("@Description", txtCatDesc.Text);
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = "Unable to update Category. Error: " + ex.Message;
            }
            finally
            {
                master.masterMessage = "Category updated";
            }
        }
    }
}