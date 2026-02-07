class JobCard {
  final String id;
  final String title;
  final String categoryLabel;
  final String description;
  final String location;
  final String date;
  final int priceGyd;

  const JobCard({
    required this.id,
    required this.title,
    required this.categoryLabel,
    required this.description,
    required this.location,
    required this.date,
    required this.priceGyd,
  });
}
