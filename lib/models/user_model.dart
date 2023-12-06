import 'dart:convert';

class User {
  final DateTime lastLogin;
  final String username;
  final String firstName;
  final String lastName;
  final DateTime dateJoined;
  final String? email;
  final bool isBusiness;
  final bool isPersonal;
  final int phoneNumber;
  final bool isVerified;
  final DateTime? lastSeen;
  final bool otpVerified;
  final int accountBalance;
  final UserProfile? userProfile;
  bool isSticked;

  User({
    required this.lastLogin,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.dateJoined,
    this.email,
    required this.isBusiness,
    required this.isPersonal,
    required this.phoneNumber,
    required this.isVerified,
    this.lastSeen,
    required this.otpVerified,
    required this.accountBalance,
    required this.userProfile,
    this.isSticked = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final user = json['user'];

    if (user != null) {
      final userProfile = UserProfile.fromJson(user['user_profile'][0]);
      return User(
        lastLogin: DateTime.parse(user['last_login']),
        username: user['username'],
        firstName: user['first_name'],
        lastName: user['last_name'],
        dateJoined: DateTime.parse(user['date_joined']),
        email: user['email'],
        isBusiness: user['is_business'],
        isPersonal: user['is_personal'],
        phoneNumber: user['phone_number'],
        isVerified: user['is_verified'],
        lastSeen: user['last_seen'] != null
            ? DateTime.parse(user['last_seen'])
            : null,
        otpVerified: user['otp_verified'],
        accountBalance: user['account_balance'],
        userProfile: userProfile,
      );
    } else {
      // Handle the case where 'user' field is null
      return User(
        lastLogin: DateTime.now(),
        username: 'Anonymous User',
        firstName: '',
        lastName: '',
        dateJoined: DateTime.now(),
        isBusiness: false,
        isPersonal: false,
        phoneNumber: 0,
        isVerified: false,
        otpVerified: false,
        accountBalance: 0,
        userProfile: null,
      );
    }
  }
}

class UserProfile {
  final String work;
  final DateTime dateOfBirth;
  final String gender;
  final String customGender;
  final String religion;
  final int mediaId;
  final int coverImageId;
  final int? addressId;
  final bool isFlagged;
  final bool hasUpdatedProfile;
  final UserImage userImage;

  UserProfile({
    required this.work,
    required this.dateOfBirth,
    required this.gender,
    required this.customGender,
    required this.religion,
    required this.mediaId,
    required this.coverImageId,
    this.addressId,
    required this.isFlagged,
    required this.hasUpdatedProfile,
    required this.userImage,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final userProfile = json['user_profile'][0];
    final userImage = UserImage.fromJson(userProfile);
    return UserProfile(
      work: userProfile['work'],
      dateOfBirth: DateTime.parse(userProfile['date_of_birth']),
      gender: userProfile['gender'],
      customGender: userProfile['custom_gender'],
      religion: userProfile['religion'],
      mediaId: userProfile['media_id'],
      coverImageId: userProfile['cover_image_id'],
      addressId: userProfile['address_id'],
      isFlagged: userProfile['is_flagged'],
      hasUpdatedProfile: userProfile['has_updated_profile'],
      userImage: userImage,
    );
  }
}

class UserImage {
  final String profileImage;

  UserImage({
    required this.profileImage,
  });

  factory UserImage.fromJson(Map<String, dynamic> json) {
    final List<dynamic> userImages = json['user_image'];
    return UserImage(
      profileImage: userImages[0]['profile_image'] ??
          'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1400&q=80',
    );
  }
}

// Helper method to parse JSON string to User object
User parseUser(String jsonString) {
  final Map<String, dynamic> jsonData = json.decode(jsonString);
  return User.fromJson(jsonData);
}



class CombinedUserPostDetails {
  final int userId;
  final String email;
  final bool isBusiness;
  final bool isPersonal;
  final String username;
  final int phoneNumber;
  final bool isVerified;
  final String lastLogin;

  final String work;
  final String dateOfBirth;
  final String gender;
  final String customGender;
  final String religion;
  final bool isFlagged;
  final bool hasUpdatedProfile;

  CombinedUserPostDetails({
    required this.userId,
    required this.email,
    required this.isBusiness,
    required this.isPersonal,
    required this.username,
    required this.phoneNumber,
    required this.isVerified,
    required this.lastLogin,
    required this.work,
    required this.dateOfBirth,
    required this.gender,
    required this.customGender,
    required this.religion,
    required this.isFlagged,
    required this.hasUpdatedProfile,
  });

  factory CombinedUserPostDetails.fromJson(Map<String, dynamic> userJson, Map<String, dynamic> postJson) {
    final userProfile = userJson['user_profile'][0];

    return CombinedUserPostDetails(
      userId: userJson['user']['id'],
      email: userJson['user']['email'],
      isBusiness: userJson['user']['is_business'],
      isPersonal: userJson['user']['is_personal'],
      username: userJson['user']['username'],
      phoneNumber: userJson['user']['phone_number'],
      isVerified: userJson['user']['is_verified'],
      lastLogin: userJson['user']['last_login'],
      work: userProfile['work'],
      dateOfBirth: userProfile['date_of_birth'],
      gender: userProfile['gender'],
      customGender: userProfile['custom_gender'],
      religion: userProfile['religion'],
      isFlagged: userProfile['is_flagged'],
      hasUpdatedProfile: userProfile['has_updated_profile'],
    );
  }
}
