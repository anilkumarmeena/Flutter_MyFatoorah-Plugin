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

class MyfatoorahActivity extends Activity implements MFSDKListener{

    String BASE_URL = "https://apidemo.myfatoorah.com/";
    String EMAIL = "apiaccount@myfatoorah.com" ;// Merchant Email
    String PASSWORD = "api12345*";  // Merchant Password

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_myfatoorah);
        Intent intent = getIntent();
        MFSDK.INSTANCE.init(BASE_URL, EMAIL, PASSWORD);
        pay(false,200,"anil meena");
    }

    private void pay(Boolean lang,double price,String name){
        InvoiceModel invoiceModel = new InvoiceModel(price,name , Country.KUWAIT, CurrencyISO.Kuwaiti_Dinar_KWD);
        if(lang){
            invoiceModel.setLanguage(InvoiceLanguage.AR);
            MFSDK.INSTANCE.createInvoice(this,"en" , invoiceModel,  PaymentMethod.KNET);
        }
        else{
            MFSDK.INSTANCE.createInvoice(this, "en", invoiceModel,  PaymentMethod.KNET);
        }
    }

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