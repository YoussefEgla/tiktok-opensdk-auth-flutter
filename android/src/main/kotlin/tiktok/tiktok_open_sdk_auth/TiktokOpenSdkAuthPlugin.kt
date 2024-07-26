package tiktok.tiktok_open_sdk_auth

import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.tiktok.open.sdk.auth.AuthApi
import com.tiktok.open.sdk.auth.AuthRequest
import com.tiktok.open.sdk.auth.AuthResponse
import com.tiktok.open.sdk.auth.utils.PKCEUtils

/** TiktokOpenSdkAuthPlugin */
class TiktokOpenSdkAuthPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null
  private var context: Context? = null
  private var authApi: AuthApi? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "tiktok_open_sdk_auth")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "init" -> {
        if (activity == null) {
          result.error("NO_ACTIVITY", "TikTok Auth requires a foreground activity.", null)
          return
        } 
        authApi = AuthApi(activity!!)
        result.success(true)
      }
      "authorize" -> {
        if (authApi == null) {
          result.error("NOT_INITIALIZED", "TikTok Auth API is not initialized.", null)
          return
        }

        val authMethod = call.argument<Int>("authMethod")!!
        val clientKey = call.argument<String>("clientKey")!!
        val scope = call.argument<String>("scope")!!
        val redirectUri = call.argument<String>("redirectUri")!!
        val callVerifier = PKCEUtils.generateCodeVerifier()

        val authRequest = AuthRequest(
            clientKey,
            scope,
            redirectUri,
            callVerifier
        )
        
        var response = authApi!!.authorize(authRequest, AuthApi.AuthMethod.values()[authMethod])
        result.success(true)
      }
      "getAuthResponseFromIntent" -> {
        if (authApi == null) {
          result.error("NOT_INITIALIZED", "TikTok Auth API is not initialized.", null)
          return
        }
        val redirectUri = call.argument<String>("redirectUri")!!
        val response = authApi!!.getAuthResponseFromIntent(activity!!.intent, redirectUri)

        result.success(true)
      }
      else -> {
        result.notImplemented()
      }
    }
  }
}
