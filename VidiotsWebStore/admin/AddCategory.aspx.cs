using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VidiotsWebStore
{
    public partial class AddCategory : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsAdminTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsAdminTemplate)this.Master;
        }

        protected void btnAddNewCategory_Click(object sender, EventArgs e)
        {
            try
            {
                InsertNewCategory();
                master.masterMessage = "Category added";
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
        }

        private void InsertNewCategory()
        {
            SqlCommand cmd = default(SqlCommand);
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                cmd = new SqlCommand("spInsertCategory", conn);
                cmd.Parameters.AddWithValue("@CategoryName", txtCategoryName.Text);
                cmd.Parameters.AddWithValue("@CategoryDescription", txtCatDesc.Text);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                conn.Open();

                cmd.ExecuteNonQuery();


            }


        }
    }
}