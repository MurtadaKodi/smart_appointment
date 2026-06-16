class ServiceProvider {
  final String id;
  final String name;
  final String image;
  final String title;
  final String description;
  final String email;
  final String phone;

  const ServiceProvider({
    required this.id,
    required this.name,
    required this.image,
    required this.title,
    required this.description,
    required this.email,
    required this.phone,
  });
}

const providers = [
  ServiceProvider(
    id: "1",
    name: "قسم الحنة",
    image: "assets/images/hina.jpg",
    title: "",
    description: "نقدم أفضل خدمات الحنة للعرائس والمناسبات الخاصة. فريقنا من الخبراء يستخدم أجود أنواع الحنة لتصميم نقشات فريدة وجميلة تناسب ذوقك وتبرز جمالك في يومك الخاص.",
    email: "provider1@example.com",
    phone: "55767001",  
  ),
  ServiceProvider(
    id: "2",
    name: "قسم التجميل",
    image: "assets/images/provider2.jpeg",
    title: "",
    description: "نقدم أفضل خدمات التجميل للعناية بالبشرة والشعر والمكياج. فريقنا من الخبراء يستخدم أحدث التقنيات والمنتجات لضمان تجربة مميزة ونتائج رائعة.",
    email: "provider2@example.com",
    phone: "+97455767001",
  ),
  ServiceProvider(
    id: "3",
    name: "قسم الشعر",
    image: "assets/images/provider3.jpeg",
    title: "",
    description: "نقدم أفضل خدمات العناية بالشعر والتصفيف. فريقنا من الخبراء يستخدم أحدث التقنيات والمنتجات لضمان تجربة مميزة ونتائج رائعة.",
    email: "provider3@example.com",
    phone: "345-678-9012",

  ),
  ServiceProvider(
    id: "4",
    name: "قسم العناية بالبشرة",
    image: "assets/images/provider4.jpeg",
    title: "",
    description: "نقدم أفضل خدمات العناية بالبشرة. فريقنا من الخبراء يستخدم أحدث التقنيات والمنتجات لضمان تجربة مميزة ونتائج رائعة.",
    email: "provider4@example.com",
    phone: "456-789-0123",
  ),
  ServiceProvider(
    id: "5",  
    name: "قسم الأظافر",
    image: "assets/images/provider5.jpeg",
    title: "",
    description: "نقدم أفضل خدمات العناية بالأظافر. فريقنا من الخبراء يستخدم أحدث التقنيات والمنتجات لضمان تجربة مميزة ونتائج رائعة.",
    email: "provider5@example.com",
    phone: "567-890-1234",
  ),
  ServiceProvider(
    id: "6",
    name: "قسم التدليك",
    image: "assets/images/provider6.jpeg",
    title: "",
    description: "نقدم أفضل خدمات التدليك والاسترخاء. فريقنا من الخبراء يستخدم أحدث التقنيات والمنتجات لضمان تجربة مميزة ونتائج رائعة.",
    email: "provider6@example.com",
    phone: "678-901-2345",
  ),
];
