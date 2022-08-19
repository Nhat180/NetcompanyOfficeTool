class MeetingRoom {
  final String name;
  final String floor;
  final int capacity;
  final double coordinatorX;
  final double coordinatorY;
  final String imgUrl;
  final List<String> equipment;


  const MeetingRoom({
    required this.name,
    required this.floor,
    required this.capacity,
    required this.coordinatorX,
    required this.coordinatorY,
    required this.imgUrl,
    required this.equipment
  });
}

const allMeetingRooms =[
  MeetingRoom(name: "Da Lat", floor: "24", capacity: 8, coordinatorY: 30, coordinatorX: 50, imgUrl: "https://user-images.githubusercontent.com/68225942/185308897-1593f125-bc90-48e4-8b52-f1c8db5ba5b6.JPG", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Hue", floor: "24", capacity: 4, coordinatorY: -300, coordinatorX: -345, imgUrl: "https://user-images.githubusercontent.com/68225942/185319040-b95511b4-ac0d-48da-bad4-b7637c53bc94.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Ha Noi", floor: "24", capacity: 10, coordinatorY: -300, coordinatorX: 55, imgUrl: "https://user-images.githubusercontent.com/68225942/185309010-61e5fb2d-8ccb-42f4-93c5-9936a1ff5962.JPG", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Can Tho", floor: "24", capacity: 6, coordinatorY: -100, coordinatorX: -80, imgUrl: "https://user-images.githubusercontent.com/68225942/185314820-27186233-4870-4c47-9c46-f938534389f0.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Nha Trang", floor: "24", capacity: 4, coordinatorY: 310, coordinatorX: 55, imgUrl: "https://user-images.githubusercontent.com/68225942/185314622-ee76e616-6b3e-4e09-9e46-81cc1bad87f0.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Ha Long", floor: "24", capacity: 1, coordinatorY: 265, coordinatorX: -460, imgUrl: "https://user-images.githubusercontent.com/68225942/185314484-ac3eea13-21d1-42da-a7fe-5a84e4448fa2.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Phu Quoc", floor: "24", capacity: 1, coordinatorY: 280, coordinatorX: -350, imgUrl: "https://user-images.githubusercontent.com/68225942/185314259-478d2396-a36d-40d9-b190-0a7185934a26.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Esbjerg", floor: "25", capacity: 4, coordinatorY: 310, coordinatorX: 35, imgUrl: "https://user-images.githubusercontent.com/68225942/185316619-531010da-8ab9-42c7-9b82-327f630918a4.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Aalborg", floor: "25", capacity: 4, coordinatorY: -315, coordinatorX: -330, imgUrl: "https://user-images.githubusercontent.com/68225942/185320105-35aef3f0-1268-4e92-bae7-3ecffdd850a3.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Copenhagen", floor: "25", capacity: 4, coordinatorY: -10, coordinatorX: 35, imgUrl: "https://user-images.githubusercontent.com/68225942/185318366-4595bce7-fb68-4e39-bf4c-da19e30948a5.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Odense", floor: "25", capacity: 10, coordinatorY: -340, coordinatorX: 35, imgUrl: "https://user-images.githubusercontent.com/68225942/185318545-94175a16-ca4d-426f-955c-31c1f8688225.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Kolding", floor: "25", capacity: 1, coordinatorY: 280, coordinatorX: -350, imgUrl: "https://user-images.githubusercontent.com/68225942/185320289-f24d5a24-e33e-4469-9369-028639ca75ba.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Randers", floor: "25", capacity: 1, coordinatorY: 265, coordinatorX: -460, imgUrl: "https://user-images.githubusercontent.com/68225942/185316299-0a267249-51fe-4916-8626-8d1f13cb7863.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Aarhus", floor: "25", capacity: 1, coordinatorY: -200, coordinatorX: 35, imgUrl: "https://user-images.githubusercontent.com/68225942/185318137-8f8a739b-6875-4b33-b905-1941493aa94e.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Ho Chi Minh City", floor: "26", capacity: 42, coordinatorY: -300, coordinatorX: 15, imgUrl: "https://user-images.githubusercontent.com/68225942/185311507-8d585907-8ee4-4d36-927c-c82c64546ee8.jpg", equipment: ["2 Air conditioners", "1 Projector","1 Projector screen", "2 Speakers", "3 Microphone", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Drammen", floor: "27", capacity: 4, coordinatorY: -315, coordinatorX: -330, imgUrl: "https://user-images.githubusercontent.com/68225942/185316927-9a555c5d-17c8-49a1-a097-8e196bda75be.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Skien", floor: "27", capacity: 1, coordinatorY: 265, coordinatorX: -460, imgUrl: "https://user-images.githubusercontent.com/68225942/185318757-53c256de-8683-4ad5-aa43-a7a48e706ac7.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Stavanger", floor: "27", capacity: 10, coordinatorY: -340, coordinatorX: 35, imgUrl: "https://user-images.githubusercontent.com/68225942/185317182-d2d90c0d-350c-4d57-8006-c0e0faf1eb59.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Trondheim", floor: "27", capacity: 4, coordinatorY: 310, coordinatorX: 35, imgUrl: "https://user-images.githubusercontent.com/68225942/185315158-0a31cec2-bb58-4d13-9d0e-e1e1db6dcc88.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Fredrikstad", floor: "27", capacity: 1, coordinatorY: 280, coordinatorX: -350, imgUrl: "https://user-images.githubusercontent.com/68225942/185313681-ef776c48-94c9-49bc-bf04-ca2b971ffafe.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Oslo", floor: "27", capacity: 4, coordinatorY: -200, coordinatorX: 35, imgUrl: "https://user-images.githubusercontent.com/68225942/185320460-8f8d3fff-6a4f-4d3c-953b-4351ecef196a.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Bergen", floor: "27", capacity: 4, coordinatorY: -10, coordinatorX: 35, imgUrl: "https://user-images.githubusercontent.com/68225942/185317443-4c94b8f8-20b2-4c14-a4f5-f82b230d1ac7.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Birmingham", floor: "31", capacity: 4, coordinatorY: -10, coordinatorX: 35, imgUrl: "https://user-images.githubusercontent.com/68225942/185310620-ad7506d3-2fbe-445d-9e6b-fdc2e1bfa7ec.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Glasgow", floor: "31", capacity: 4, coordinatorY: 310, coordinatorX: 35, imgUrl: "https://user-images.githubusercontent.com/68225942/185319876-576bbb1c-9671-4a27-a706-95aeae66a15d.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Leeds", floor: "31", capacity: 4, coordinatorY: -315, coordinatorX: -330, imgUrl: "https://user-images.githubusercontent.com/68225942/185311125-25344f40-fffa-4c91-b8c3-363d67188515.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "London", floor: "31", capacity: 10, coordinatorY: -340, coordinatorX: 35, imgUrl: "https://user-images.githubusercontent.com/68225942/185310762-de8dabd8-b828-4981-a19d-1db453685c28.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Manchester", floor: "31", capacity: 4, coordinatorY: -200, coordinatorX: 35, imgUrl: "https://user-images.githubusercontent.com/68225942/185310458-885e55a5-7dc3-44de-ad12-7466021f3838.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Liverpool", floor: "31", capacity: 1, coordinatorY: 265, coordinatorX: -460, imgUrl: "https://user-images.githubusercontent.com/68225942/185310281-ef68596d-b478-4b31-b894-b515a108918d.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),
  MeetingRoom(name: "Southampton", floor: "31", capacity: 1, coordinatorY: 280, coordinatorX: -350, imgUrl: "https://user-images.githubusercontent.com/68225942/185309964-b465abeb-cd06-490c-84e4-46125a2b8ca4.jpg", equipment: ["1 Air conditioner", "1 TV/Monitor", "1 Quartet Glass Whiteboard", "2 Markers", "1 Whiteboard Eraser"]),

];