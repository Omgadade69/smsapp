import 'package:flutter/material.dart';
//import 'package:sms/screens/home/modules/complaints/addcomplaint.dart';
//import 'package:sms/screens/home/modules/complaints/complaint.dart';
import 'package:sms/screens/home/modules/contacts/addemergencycontact.dart';
import 'package:sms/screens/home/modules/contacts/contacts.dart';
import 'package:sms/screens/home/modules/health/health.dart';
import 'package:sms/screens/home/modules/health/quarantinesummary.dart';
import 'package:sms/screens/home/modules/notice/addnotice.dart';
import 'package:sms/screens/home/modules/notice/notice.dart';
import 'package:sms/screens/home/modules/notice/translation.dart';
import 'package:sms/screens/home/modules/profile/editEmail.dart';
import 'package:sms/screens/home/modules/profile/editName.dart';
import 'package:sms/screens/home/modules/profile/editPassword.dart';
import 'package:sms/screens/home/modules/profile/editPhoneNumber.dart';
import 'package:sms/screens/home/modules/profile/editflat.dart';
import 'package:sms/screens/home/modules/profile/profile.dart';
import 'package:sms/screens/home/modules/social/wrappersocial.dart';
import 'package:sms/screens/home/modules/visitor/addvisitor.dart';
import 'package:sms/screens/home/modules/visitor/visitor.dart';
import 'package:sms/screens/home/modules/voting/addvoting.dart';
import 'package:sms/screens/home/modules/voting/voting.dart';
import 'package:sms/screens/home/modules/chat/chat.dart';
import 'package:sms/screens/home/admin/residents.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  Chat.id: (context) => Chat(),
  Profile.id: (context) => Profile(),
  EditName.id: (context) => EditName(),
  EditEmail.id: (context) => EditEmail(),
  EditPhoneNumber.id: (context) => EditPhoneNumber(),
  EditPassword.id: (context) => EditPassword(),
  EditFlat.id: (context) => EditFlat(),
  Notice.id: (context) => Notice(),
  AddNotice.id: (context) => AddNotice(editTitle: '', editNotice: '', docid: ''),
  Translate.id: (context) => Translate(title: '', notice: '', outputLanguage: '',),
  Voting.id: (context) => Voting(),
  AddVoting.id: (context) => AddVoting(),
  //Complaint.id: (context) => Complaint(),
  //AddComplaint.id: (context) => AddComplaint(),
  Contacts.id: (context) => Contacts(),
  AddEmergencyContact.id: (context) => AddEmergencyContact(currentProfilePicture: '', flag: null,),
  Health.id: (context) => Health(),
  QuarantineSummary.id: (context) => QuarantineSummary(),
  Visitor.id: (context) => Visitor(),
  AddVisitor.id: (context) => AddVisitor(name: '', wing: '', flatno: '', mobileNo: '', purpose: '', docid: ''),
  Residents.id: (context) => Residents(),
  WrapperSocial.id: (context) => WrapperSocial(),
};