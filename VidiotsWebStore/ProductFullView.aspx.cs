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
    public partial class ProductFullView : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            string prodId = Request.QueryString["productId"];
            if (!string.IsNullOrEmpty(prodId))
            {
                LoadProductInfo(prodId);
            }

        }

        private void LoadProductInfo(string id)
        {
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);

            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spGetFullProductByID", conn);
                    cmd.Parameters.AddWithValue("@ID", id);
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();

                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

                    if (dr.HasRows)
                    {
                        dr.Read();
                        productName.InnerText = dr["ProductName"].ToString();
                        productDescription.InnerText = dr["FullDescription"].ToString();
                        imgProduct.ImageUrl = dr["ImageURL"].ToString();
                        price.InnerText = string.Format("{0:c}",Convert.ToDouble(dr["Price"].ToString()));



                    }
                    else
                    {

                    }
                }
            }
            catch (Exception ex)
            {

            }
            finally
            {
                dr.Close();
            }
        }
    }
}