package com.example.flutter_myfatoorah;

import android.app.Activity;
import android.os.Bundle;
import android.content.Intent;
import android.util.Log;
import com.google.gson.Gson;
import com.myfatoorah.sdk.MFSDKListener;
import com.myfatoorah.sdk.model.invoice.InvoiceModel;
import com.myfatoorah.sdk.model.transaction.TransactionResponseModel;
import com.myfatoorah.sdk.utils.*;
import com.myfatoorah.sdk.views.MFSDK;
import org.jetbrains.annotations.NotNull;

public class PaymentActivity extends Activity implements MFSDKListener {

    private int Language;
    private String Name;
    private double Price;
    private String payment_method;
    public static String Ex_BASE_URL = "BASE_URL";
    public static String Ex_EMAIL = "EMAIL";
    public static String Ex_PASSWORD = "PASSWORD";
    public static String Ex_Language = "Language";
    public static String Ex_Name = "Name";
    public static String Ex_Price = "Price";
    public static String Ex_payment = "payment_method";



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_payment);
        Intent intent = getIntent();
        String BASE_URL = intent.getStringExtra(Ex_BASE_URL);
        // Merchant Email
        String EMAIL = intent.getStringExtra(Ex_EMAIL);
        // Merchant Password
        String PASSWORD = intent.getStringExtra(Ex_PASSWORD);
        payment_method = intent.getStringExtra(Ex_payment);
        Language = intent.getIntExtra(Ex_Language,false);
        Name = intent.getStringExtra(Ex_Name);
        Price = intent.getDoubleExtra(Ex_Price,0.0);
        MFSDK.INSTANCE.init(BASE_URL, EMAIL, PASSWORD);
        startpay();
    }

    private void startpay() {
        InvoiceModel invoiceModel = new InvoiceModel(Price, Name, Country.KUWAIT, CurrencyISO.Kuwaiti_Dinar_KWD);
        if (Language == 1) {
            invoiceModel.setLanguage(InvoiceLanguage.AR);
            MFSDK.INSTANCE.createInvoice(this, "ar", invoiceModel, PaymentMethod.ALL);
        } else {
            MFSDK.INSTANCE.createInvoice(this, "en", invoiceModel, payment_method);
        }
    }
    @SuppressWarnings("unused")
    @Override
    public void onSuccess(@NotNull TransactionResponseModel transactionResponseModel) {
        String data = new Gson().toJson(transactionResponseModel);
        String text = "Success\n\nResponse:\n\n" + data;
        try {
            Intent back = new Intent();
            back.putExtra("data", data);
            setResult(Activity.RESULT_OK, back);
            finish();
        } catch (Exception e) {
            Log.e("MFSDKLISTNER", "Exception in onPaymentSuccess", e);
        }

    }
    @SuppressWarnings("unused")
    @Override
    public void onFailed(int i, @NotNull String s) {
        String text = "Failed: $statusCode\n\nError Message:\n\n$error";
        try {
            Intent back = new Intent();
            back.putExtra("data", text);
            setResult(Activity.RESULT_CANCELED, back);
            finish();
        } catch (Exception e) {
            Log.e("MFSDKLISTNER", "Exception in onPaymentError", e);
        }

    }
    @SuppressWarnings("unused")
    @Override
    public void onCanceled(@NotNull String error) {
        String text = "payment canceled";
        try {
            Intent back = new Intent();
            back.putExtra("data", text);
            setResult(Activity.RESULT_CANCELED, back);
            finish();
        } catch (Exception e) {
            Log.e("MFSDKLISTNER", "Exception in onPaymentError", e);
        }
    }
}
