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
    public partial class OrderDetails : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsTemplate)this.Master;
            if (!IsPostBack)
            {
                string orderId = Request.QueryString["orderId"];
                if (String.IsNullOrEmpty(orderId))
                {
                    master.masterMessage = "Invalid Order Number.";
                }
                else
                {
                    DisplayCartItem(orderId);
                }
            }
        }

        private void DisplayCartItem(string orderId)
        {
            try
            {
                SqlDataReader dr = default(SqlDataReader);
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    SqlCommand cmd = new SqlCommand("spGetOrderDetails", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@OrderHistoryID", int.Parse(orderId)));
                    conn.Open();

                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        grvCart.DataSource = dr;
                        grvCart.DataBind();
                        CalculateSubTotal();
                        GetShippingAddress(orderId);
                    }
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
        }

        private void GetShippingAddress(string orderId)
        {
            try
            {
                SqlDataReader dr = default(SqlDataReader);
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    SqlCommand cmd = new SqlCommand("spGetCustomerShippingAddress", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@OrderHistoryID", int.Parse(orderId)));
                    conn.Open();

                    dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        txtStreet.Text = dr["Street"].ToString();
                        txtCity.Text = dr["City"].ToString();
                        txtCountry.Text = dr["Country"].ToString();
                        txtProvince.Text = dr["Province"].ToString();
                        txtPostal.Text = dr["PostalCode"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
        }

        private void CalculateSubTotal()
        {
            double orderSubtotal = 0;
            foreach (GridViewRow row in grvCart.Rows)
            {
                if (row.Cells[4].Text.Contains("$"))
                {
                    string itemSub = row.Cells[4].Text.Replace('$', ' ');
                    orderSubtotal += double.Parse(itemSub);
                }
                else
                {
                    orderSubtotal += double.Parse(row.Cells[4].Text);
                }
            }

            lblOrderSubtotal.Text += String.Format("{0:c}", orderSubtotal);
            CalculateShipping(orderSubtotal);
            CalculateOrderTotal(orderSubtotal, CalculateShipping(orderSubtotal));
        }

        private double CalculateShipping(double orderSubtotal)
        {
            double shippingCost = 0;
            if (orderSubtotal <= 35.00)
            {
                shippingCost = 7.00;
            }
            else if (orderSubtotal > 35.00 && orderSubtotal <= 75.00)
            {
                shippingCost = 12.00;
            }
            else
            {
                shippingCost = 0.00;
            }

            return shippingCost;
        }

        private void CalculateOrderTotal(double orderSubtotal, double shipping)
        {
            double taxAmount = (orderSubtotal * 1.15) - orderSubtotal;
            lblShippingCost.Text += String.Format("{0:c}", shipping);
            lblTax.Text += String.Format("{0:c}", taxAmount);
            double total = (orderSubtotal + shipping + taxAmount);
            lblOrderTotal.Text += String.Format("{0:c}", total);

        }
    }
}
