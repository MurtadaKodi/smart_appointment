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
    name: "Provider 1",
    image: "assets/images/provider1.jpeg",
    title: "Title 1",
    description: "Description 1",
    email: "provider1@example.com",
    phone: "55767001",  
  ),
  ServiceProvider(
    id: "2",
    name: "Provider 2",
    image: "assets/images/provider2.jpeg",
    title: "Title 2",
    description: "Description 2",   
    email: "provider2@example.com",
    phone: "+97455767001",
  ),
  ServiceProvider(
    id: "3",
    name: "Provider 3",
    image: "assets/images/provider3.jpeg",
    title: "Title 3",
    description: "Description 3",
    email: "provider3@example.com",
    phone: "345-678-9012",

  ),
  ServiceProvider(
    id: "4",
    name: "Provider 4",
    image: "assets/images/provider4.jpeg",
    title: "Title 4",
    description: "Description 4",     
    email: "provider4@example.com",
    phone: "456-789-0123",
  ),
  ServiceProvider(
    id: "5",  
    name: "Provider 5",
    image: "assets/images/provider5.jpeg",
    title: "Title 5",
    description: "Description 5",
    email: "provider5@example.com",
    phone: "567-890-1234",
  ),
  ServiceProvider(
    id: "6",
    name: "Provider 6",
    image: "assets/images/provider6.jpeg",
    title: "Title 6",
    description: "Description 6",
    email: "provider6@example.com",
    phone: "678-901-2345",
  ),
];
