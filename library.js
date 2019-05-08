function clearField(aControl) {
        aControl.className = "user"
        aControl.value = ""
}
function goFind(aString) {
        qry = "http://www.google.co.uk/search?q=site%3A"
        qry += "www.bouquetwines.com"
        window.location = qry + "+" + aString
        return false // prevents submitting form to server
}
