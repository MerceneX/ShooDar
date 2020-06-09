String mapFirebaseErrorToSlovene(String message) {
  switch (message) {
    case "The password is invalid or the user does not have a password.":
      return "Napačno geslo, ali pa uporabnik ne obstaja.";
      break;
    case "We have blocked all requests from this device due to unusual activity. Try again later. [ Too many unsuccessful login attempts. Please try again later. ]":
      return "Preveč zaporednih neuspešnih poskusov vpisa. Prosimo, poskusite ponovno kasneje.";
      break;
    case "The email address is already in use by another account.":
      return "Ta e-mail je že v uporabi.";
      break;
    default:
      return message;
      break;
  }
}
