package com.example.egrocer;
public class OrderDetail {
    private String itemName;
    private float subtotal;
    private float shipping;
    private float tax;
    private float total;
 
    public OrderDetail(String itemName, String subtotal, String shipping, String tax, String total) {
        this.itemName = itemName;
        this.subtotal = Float.parseFloat(subtotal);
        this.shipping = Float.parseFloat(shipping);
        this.tax = Float.parseFloat(tax);
        this.total = Float.parseFloat(total);
    }
 
    public String getItemName() {
        return itemName;
    }
 
    public String getSubtotal() {
        return String.format("%.2f", subtotal);
    }
 
    public String getShipping() {
        return String.format("%.2f", shipping);
    }
 
    public String getTax() {
        return String.format("%.2f", tax);
    }
     
    public String getTotal() {
        return String.format("%.2f", total);
    }
}
