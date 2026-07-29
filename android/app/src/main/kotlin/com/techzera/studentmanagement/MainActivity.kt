package com.techzera.studentmanagement

import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import com.google.gson.Gson
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

import com.easebuzz.payment.kit.PWECouponsActivity
import datamodels.PWEStaticDataModel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "easebuzz"
    var channel_result: MethodChannel.Result? = null
    private var start_payment = true

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        start_payment = true
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                channel_result = result
                if (call.method == "payWithEasebuzz") {
                    Toast.makeText(this, "payWithEasebuzz called", Toast.LENGTH_SHORT).show()
                    if (start_payment) {
                        start_payment = false
                        startPayment(call.arguments)
                    } else {
                        Toast.makeText(this, "Payment already in progress, ignoring", Toast.LENGTH_SHORT).show()
                    }
                }
            }
    }

    private fun startPayment(arguments: Any) {
        try {
            Toast.makeText(this, "Building payment intent...", Toast.LENGTH_SHORT).show()

            val gson = Gson()
            val parameters = JSONObject(gson.toJson(arguments))
            val intentProceed = Intent(activity, PWECouponsActivity::class.java)
            intentProceed.flags = Intent.FLAG_ACTIVITY_REORDER_TO_FRONT
            val keys: Iterator<*> = parameters.keys()
            while (keys.hasNext()) {
                var value: String? = ""
                val key = keys.next() as String
                value = parameters.optString(key)
                if (key == "amount") {
                    val amount: Double = parameters.optDouble("amount")
                    intentProceed.putExtra(key, amount)
                } else {
                    intentProceed.putExtra(key, value)
                }
            }

            Toast.makeText(this, "Launching Easebuzz activity", Toast.LENGTH_SHORT).show()
            startActivityForResult(intentProceed, PWEStaticDataModel.PWE_REQUEST_CODE)
        } catch (e: Exception) {
            start_payment = true
            Toast.makeText(this, "Payment start failed: ${e.message}", Toast.LENGTH_LONG).show()

            val error_map: MutableMap<String, Any> = HashMap()
            val error_desc_map: MutableMap<String, Any> = HashMap()
            val error_desc = "exception occured:" + e.message
            error_desc_map["error"] = "Exception"
            error_desc_map["error_msg"] = error_desc
            error_map["result"] = PWEStaticDataModel.TXN_FAILED_CODE
            error_map["payment_response"] = error_desc_map
            channel_result?.success(error_map)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == PWEStaticDataModel.PWE_REQUEST_CODE) {
            start_payment = true
            Toast.makeText(this, "Returned from Easebuzz activity", Toast.LENGTH_SHORT).show()

            val response = JSONObject()
            val error_map: MutableMap<String, Any> = HashMap()

            if (data != null) {
                val result = data.getStringExtra("result")
                val payment_response = data.getStringExtra("payment_response")
                try {
                    val obj = JSONObject(payment_response)
                    response.put("result", result)
                    response.put("payment_response", obj)
                    channel_result?.success(JsonConverter.convertToMap(response))
                } catch (e: Exception) {
                    Toast.makeText(this, "Result parse failed: ${e.message}", Toast.LENGTH_LONG).show()

                    val error_desc_map: MutableMap<String, Any> = HashMap()
                    // Used the below code for target API 30
                    error_desc_map["error"] = result.toString()
                    error_desc_map["error_msg"] = payment_response.toString()
                    error_map["result"] = result.toString()
                    // End code for target API 30
                    error_map["payment_response"] = error_desc_map
                    channel_result?.success(error_map)
                }
            } else {
                Toast.makeText(this, "Empty payment response from Easebuzz", Toast.LENGTH_LONG).show()

                val error_desc_map: MutableMap<String, Any> = HashMap()
                val error_desc = "Empty payment response"
                error_desc_map["error"] = "Empty error"
                error_desc_map["error_msg"] = error_desc
                error_map["result"] = "payment_failed"
                error_map["payment_response"] = error_desc_map
                channel_result?.success(error_map)
            }
        } else {
            super.onActivityResult(requestCode, resultCode, data)
        }
    }
}