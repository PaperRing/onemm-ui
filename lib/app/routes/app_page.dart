import 'package:get/get.dart';
import 'package:onemm/app/binding/my_binding.dart';
import 'package:onemm/app/routes/app_routes.dart';
import 'package:onemm/app/ui/liked_place/liked_place_page.dart';
import 'package:onemm/app/ui/my_page/component/following_page.dart';
import 'package:onemm/app/ui/my_page/component/login_view.dart';
import 'package:onemm/app/ui/my_page/component/my_page_review.dart';
import 'package:onemm/app/ui/my_page/component/my_theme_list.dart';
import 'package:onemm/app/ui/my_page/my_page.dart';
import 'package:onemm/app/ui/nearby/review/all_review_by_store_page.dart';
import 'package:onemm/app/ui/nearby/review/update_review_page.dart';
import 'package:onemm/app/ui/nearby/review/write_review_page.dart';
import 'package:onemm/app/ui/nearby/store_detail_info/store_detail_info_page.dart';
import 'package:onemm/app/ui/other_user/other_user_page.dart';
import 'package:onemm/app/ui/search/component/search_result_page.dart';
import 'package:onemm/app/ui/search/search_page.dart';
import 'package:onemm/app/ui/theme_list/theme_list_detail_page.dart';
import 'package:onemm/app/ui/walk/walk_page.dart';

import '../ui/exception/error_page.dart';
import '../ui/home/component/main_theme_list.dart';
import '../ui/home/home_page.dart';
import '../ui/liked_place/component/like_stores_more_page.dart';
import '../ui/my_page/component/follower_page.dart';
import '../ui/my_page/component/my_theme_list_detail.dart';
import '../ui/my_page/edit_user_info_page.dart';
import '../ui/nearby/near_by_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.INITIAL, page: () => HomePage(), binding: MyBinding()),
    GetPage(name: AppRoutes.WALK, page: () => WalkPage(), binding: MyBinding()),
    GetPage(name: AppRoutes.LIKED, page: () => LikedPlacePage(), binding: MyBinding()),
    GetPage(name: AppRoutes.LIKED_STORES, page: () => LikeStoreMorePage(), binding: MyBinding()),
    GetPage(name: AppRoutes.MAIN_THEME_LIST, page: () => MainThemeList(), binding: MyBinding()),
    GetPage(name: AppRoutes.THEME_LIST, page: () => ThemeListDetailPage(), binding: MyBinding()),
    GetPage(name: AppRoutes.NEARBY, page: () => NearByPage(selected: 0), binding: MyBinding()),
    GetPage(name: AppRoutes.STORE_SAVE_REVIEW, page: () => WriteReviewPage(), binding: MyBinding()),
    GetPage(name: AppRoutes.STORE_DETAIL, page: () => StoreDetailInfoPage(), binding: MyBinding()),
    GetPage(name: AppRoutes.STORE_UPDATE_REVIEW, page: () => UpdateReviewPage(), binding: MyBinding()),
    GetPage(name: AppRoutes.STORE_ALL_REVIEW, page: () => AllReviewByStorePage(), binding: MyBinding()),
    GetPage(name: AppRoutes.MYPAGE, page: () => MyPage(), binding: MyBinding()),
    GetPage(name: AppRoutes.MYPAGE_REVIEW, page: () => MyReviewPage(), binding: MyBinding()),
    GetPage(name: AppRoutes.MY_EDIT, page: () => EditUserInfoPage(), binding: MyBinding()),
    GetPage(name: AppRoutes.MY_THEME_LIST, page: () => MyThemeListPage(), binding: MyBinding()),
    GetPage(name: AppRoutes.MY_THEME_LIST_DETAIL, page: () => MyThemeListDetailPage(), binding: MyBinding()),
    GetPage(name: AppRoutes.LOGIN, page: () => LoginView(), binding: MyBinding()),
    GetPage(name: AppRoutes.SEARCH, page: () => SearchPage(), binding: MyBinding()),
    GetPage(name: AppRoutes.SEARCH_RESULT, page: () => SearchResultPage(), binding: MyBinding()),
    GetPage(name: AppRoutes.OTHER_USER_PAGE, page: () => OtherUserPage(), binding: MyBinding()),
    GetPage(name: AppRoutes.FOLLOWER, page: () => FollowerPage(), binding: MyBinding()),
    GetPage(name: AppRoutes.FOLLOWING, page: () => FollowingPage(), binding: MyBinding()),
    GetPage(name: AppRoutes.FOLLOWING, page: () => FollowingPage(), binding: MyBinding()),
    GetPage(name: AppRoutes.ERROR, page: () => ErrorPage()),
  ];
}
