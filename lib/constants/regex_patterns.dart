final number = RegExp(r'[0-9]');
final alphabets = RegExp(r'[a-zA-Z]+');
final alphabetsSpace = RegExp(r'[a-zA-Z ]+');
final alphabetsAndNumbersPassword = RegExp(r'[a-zA-Z0-9 ,_.@$#!&*]+');
final alphabetsAndNumbers = RegExp(r'[a-zA-Z0-9 ,./]+');
final emailOnly = RegExp(r'[a-zA-Z0-9_.@]+');
final alphabetsAndNumbersWithoutSpace = RegExp(r'[a-zA-Z0-9]+');
final bloodGroup = RegExp(r'[aboABO1 +-]+');
final alphabetsNumbersEmail = RegExp(r'[a-zA-Z0-9 ,.@/]+');
final alphabetsSpaceSpecialCharacters = RegExp(r'[a-zA-Z @&\-_.]+');
final gstRegExp =
    RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[0-9]{1}[A-Z]{1}[0-9]{1}$');
