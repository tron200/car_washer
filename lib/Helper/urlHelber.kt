package Helper

class urlHelber {
    var BASE = "https://lamaah.ae/"
    var STRIPE_TOKEN = "pk_test_LTXZTPA9yepu9dEodKsJm6GA"
    var GET_USERREVIEW = BASE + "api/provider/review"
    var GET_NOTIFICATIONS = BASE + "api/provider/notification"
    var UPCOMING_TRIP_DETAILS = BASE + "api/provider/requests/upcoming/details"
    var UPCOMING_TRIPS = BASE + "api/provider/requests/upcoming"
    var CANCEL_REQUEST_API = BASE + "api/provider/cancel"
    var TARGET_API = BASE + "api/provider/target"
    var RESET_PASSWORD = BASE + "api/provider/reset/password"
    var FORGET_PASSWORD = BASE + "api/provider/forgot/password"
    var FACEBOOK_LOGIN = BASE + "api/provider/auth/facebook"
    var GOOGLE_LOGIN = BASE + "api/provider/auth/google"
    var LOGOUT = BASE + "api/provider/logout"
    var SUMMARY = BASE + "api/provider/summary"
    var HELP = BASE + "api/provider/help"
    var COMPLAINT = BASE + "api/user/createComplaint"
    var SAVE_LOCATION = BASE + "api/user/createDefaultLocation"
    var ADD_COUPON_API = BASE + "api/user/promocode/add"
    var COUPON_LIST_API = BASE + "api/user/promocodes"
    var GET_WITHDRAW_LIST = BASE + "api/provider/withdrawaList"

    var GET_CARD_LIST_DETAILS = BASE + "api/provider/BankList"
    var GET_ADD_BANK_DETAILS = BASE + "api/provider/addBank?account_name="
    var WITHDRAW_REQUEST = BASE + "api/provider/withdrawalRequest?provider_id="
    var HELP_URL = BASE
    var login = BASE + "api/provider/oauth/token"
    var register = BASE + "api/provider/register"
    var email_check = BASE + "api/provider/check-email"
    var USER_PROFILE_API = BASE + "api/provider/profile"
    var UPDATE_AVAILABILITY_API = BASE + "api/provider/profile/available"
    var GET_HISTORY_API = BASE + "api/provider/requests/history"
    var GET_HISTORY_DETAILS_API = BASE + "api/provider/requests/history/details"
    var CHANGE_PASSWORD_API = BASE + "api/provider/profile/password"

    var CHECK_DOCUMENT = BASE + "api/provider/document/checkDocument"
    var COMPLETE_DOCUMENT = BASE + "api/provider/document/checkDocument?term_n=1"

    var ChatGetMessage = BASE + "api/provider/firebase/getChat?request_id="
}