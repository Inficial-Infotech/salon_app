// For generate Map
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:salon_app/app/ui/constants/ApiConstants.dart';
import 'package:salon_app/app/ui/theme/app_colors.dart';
import 'math_utils.dart';

CachedNetworkImage getImageView(String url,
    {String finalUrl,
    height = 100.0,
    width = 100.0,
    double errorHeight = 100.0,
    double errorWidth = 100.0,
    placeHolderImage = '',
    fit: BoxFit.contain,
    bool isFitApply = true,
    Decoration shape}) {
  String imageUrl = !isNullEmptyOrFalse(finalUrl)
      ? finalUrl
      : (url == null || url.length == 0)
          ? ""
          : ((url.startsWith("images") || url.startsWith("/"))
              ? (ApiConstants.imageBaseURL + url)
              : url);
  return new CachedNetworkImage(
    height: height,
    width: width,
    imageUrl: imageUrl,
    fit: fit,
    placeholder: (context, url) => Container(
      height: height,
      width: width,
      decoration: shape != null ? shape : null,
      child: isNullEmptyOrFalse(imageUrl)
          ? Image.asset(
              placeHolderImage,
              width: errorWidth,
              height: errorHeight,
              fit: isFitApply ? fit : null,
            )
          : SpinKitFadingCircle(
              color: ColorConstants.primaryColor,
              size: getSize(20),
            ),
    ),
    errorWidget: (context, url, error) => Image.asset(
      placeHolderImage == null || placeHolderImage.length == 0
          ? "placeHolder" //ADD PLACE HOLDER IMAGE
          : placeHolderImage,
      width: errorWidth,
      height: errorHeight,
      fit: isFitApply ? fit : null,
    ),
  );
}

// static func getGoogleMapImageUrl(size:CGSize, startLocation:LocationModel, endLocation:LocationModel) -> String {

//         let strUrl1 = "http://maps.google.com/maps/api/staticmap?path=color:0x3C97D3FF|weight:4|\(startLocation.latitude),\(startLocation.longitude)|\(endLocation.latitude),\(endLocation.longitude)&size=\(Int(size.width))x\(Int(size.height))&sensor=true&markers=size:".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

//         let strUrl2 = "tiny%7C"

//         let strUrl3 = "color:0xFF0000FF|\(startLocation.latitude),\(startLocation.longitude)|\(endLocation.latitude),\(endLocation.longitude)&key=\(AppConstants.googleApiKeyForImage)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

//         return "\(strUrl1)\(strUrl2)\(strUrl3)"

//         //        return "http://maps.google.com/maps/api/staticmap?path=color:0x3C97D3FF|weight:4|21.171021,72.854210|21.267553,72.960861&size=\(Int(size.width))x\(Int(size.height))&sensor=true&markers=size:mid%7Ccolor:0xFF0000FF|21.171021,72.854210|21.267553,72.960861&key=\(AppConstants.googleApiKeyForImage)"
//         //            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

//     }
