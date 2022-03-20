package Helper;

public class URLHelper {
    companion object {
        const val APP_URL = "";
        val client_id = 2
        val client_secret = "WifS1rMi3LvuorP1G2UdtKZairUNSH2iMqrKivPf"

        val BASE = "https://lamaah.ae/"
        val STRIPE_TOKEN = "pk_test_LTXZTPA9yepu9dEodKsJm6GA"
        val GET_USERREVIEW = BASE + "api/provider/review"
        val GET_NOTIFICATIONS = BASE + "api/provider/notification"
        val UPCOMING_TRIP_DETAILS = BASE + "api/provider/requests/upcoming/details"
        val UPCOMING_TRIPS = BASE + "api/provider/requests/upcoming"
        val CANCEL_REQUEST_API = BASE + "api/provider/cancel"
        val TARGET_API = BASE + "api/provider/target"
        val RESET_PASSWORD = BASE + "api/provider/reset/password"
        val FORGET_PASSWORD = BASE + "api/provider/forgot/password"
        val FACEBOOK_LOGIN = BASE + "api/provider/auth/facebook"
        val GOOGLE_LOGIN = BASE + "api/provider/auth/google"
        val LOGOUT = BASE + "api/provider/logout"
        val SUMMARY = BASE + "api/provider/summary"
        val HELP = BASE + "api/provider/help"
        val COMPLAINT = BASE + "api/user/createComplaint"
        val SAVE_LOCATION = BASE + "api/user/createDefaultLocation"
        val ADD_COUPON_API = BASE + "api/user/promocode/add"
        val COUPON_LIST_API = BASE + "api/user/promocodes"
        val GET_WITHDRAW_LIST = BASE + "api/provider/withdrawaList"

        val GET_CARD_LIST_DETAILS = BASE + "api/provider/BankList"
        val GET_ADD_BANK_DETAILS = BASE + "api/provider/addBank?account_name="
        val WITHDRAW_REQUEST = BASE + "api/provider/withdrawalRequest?provider_id="
        val HELP_URL = BASE
        val login = BASE + "api/provider/oauth/token"
        val register = BASE + "api/provider/register"
        val email_check = BASE + "api/provider/check-email"
        val USER_PROFILE_API = BASE + "api/provider/profile"
        val UPDATE_AVAILABILITY_API = BASE + "api/provider/profile/available"
        val GET_HISTORY_API = BASE + "api/provider/requests/history"
        val GET_HISTORY_DETAILS_API = BASE + "api/provider/requests/history/details"
        val CHANGE_PASSWORD_API = BASE + "api/provider/profile/password"

        val CHECK_DOCUMENT = BASE + "api/provider/document/checkDocument"
        val COMPLETE_DOCUMENT = BASE + "api/provider/document/checkDocument?term_n=1"

        val ChatGetMessage = BASE + "api/provider/firebase/getChat?request_id="
    }
}