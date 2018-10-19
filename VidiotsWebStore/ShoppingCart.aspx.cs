﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VidiotsWebStore
{
    public partial class ShoppingCart : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsTemplate)this.Master;
            if (!IsPostBack)
            {
                if(Request.Cookies["cartID"] != null)
                {
                    string cartID = Request.Cookies["cartID"].Value;
                    AddToCart(cartID);
                    DisplayCartItem(cartID);
                }
                else
                {
                    string cartID = CreateNewCart();
                    AddToCart(cartID);
                    Response.Cookies["cartID"].Value = cartID;
                    Response.Cookies["cartID"].Expires = DateTime.Now.AddHours(1);
                    DisplayCartItem(cartID);
                }
            }

            string prodID = Request.QueryString["ProductId"];
            if (!string.IsNullOrEmpty(prodID))
            {
                RemoveFromCart(prodID);
            }
        }

        private void RemoveFromCart(string prodID)
        {
            
        }

        private void DisplayCartItem(string cartID)
        {
            try
            {
                SqlDataReader dr = default(SqlDataReader);
                string prodId = Request.Cookies["productID"].Value;
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    SqlCommand cmd = new SqlCommand("spGetCartItems", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@ProductID", int.Parse(prodId)));
                    cmd.Parameters.Add(new SqlParameter("@CartID", int.Parse(cartID)));
                    conn.Open();

                    dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {
                        rptCart.DataSource = dr;
                        rptCart.DataBind();
                    }
                }
            }
            catch(Exception ex)
            {

            }
            
        }

        private string CreateNewCart()
        {
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                SqlCommand cmd = new SqlCommand("spCreateCart", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                SqlParameter output = new SqlParameter("@CartID", System.Data.SqlDbType.Int);
                output.Direction = System.Data.ParameterDirection.Output;
                cmd.Parameters.Add(output);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;



                cmd.Connection.Open();

                cmd.ExecuteNonQuery();
                string id = output.Value.ToString();
                return id;
            }
        }

        private void AddToCart(string cartID)
        {
            try
            {
                string prodId = Request.Cookies["productID"].Value;
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    SqlCommand cmd = new SqlCommand("spAddItemToCart", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@CartID", int.Parse(cartID)));
                    cmd.Parameters.Add(new SqlParameter("@ProductID", int.Parse(prodId)));
                    cmd.Parameters.Add(new SqlParameter("@Quantity", 1));

                    cmd.Connection.Open();

                    cmd.ExecuteNonQuery();
                }
            }
            catch(Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/CustomerLogin.aspx?fromCheckOut=1");
        }
    }
}