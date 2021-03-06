import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodzilla/models/restaurant_detail.dart';
import 'package:foodzilla/models/restaurant_model.dart';
import 'package:foodzilla/models/transaction_model.dart';
import 'package:foodzilla/models/user_model.dart';
import 'package:foodzilla/providers/date_time_provider.dart';
import 'package:foodzilla/providers/restaurant_detail_provider.dart';
import 'package:foodzilla/providers/scheduling_provider.dart';
import 'package:foodzilla/providers/theme_provider.dart';
import 'package:foodzilla/screens/settings_screen.dart';
import 'package:foodzilla/services/notofication_helper.dart';
import 'package:foodzilla/shared/constants.dart';
import 'package:foodzilla/services/services.dart';
import 'package:foodzilla/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

part 'favourite_screen.dart';
part 'detail_screen.dart';
part 'welcome_screen.dart';
part 'wrapper.dart';
part 'sign_in_screen.dart';
part 'current_screen.dart';
part 'sign_up_screen.dart';
part 'home_screen.dart';
part 'profile_screen.dart';
part 'order_screen.dart';
part 'overview_screen.dart';
part 'menu_screen.dart';
part 'booking_screen.dart';
part 'order_detail_screen.dart';
part 'review_screen.dart';
part 'search_screen.dart';
part 'booking_success_screen.dart';