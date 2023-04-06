class Referral {
  late int id;
  late int userid;
  late String title;
  late String price;
  late String desc;
  late String company;
  late String address;
  late double rating;
  late String firstName;
  late String lastName;

  Referral(this.id, this.userid, this.title, this.price, this.desc,
      this.company, this.address, this.rating, this.firstName, this.lastName);

  Referral.fromJSON(dynamic data)
      : id = data['referral_id'],
        userid = data['user_id'],
        title = data['job_title'],
        price = data['price'],
        desc = data['job_description'],
        company = data['company'],
        address = data['address'],
        firstName = data['first_name'],
        lastName = data['last_name'],
        rating = data['rating'].runtimeType == 10.runtimeType
            ? (data['rating'] as int).toDouble()
            : data['rating'];
}
