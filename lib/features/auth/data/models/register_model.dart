class RegisterModel {
	String? id;
	String? email;
	String? phone;
	String? fullName;
	bool? isActive;
	dynamic code;
	String? role;
	DateTime? createdAt;
	DateTime? updatedAt;

	RegisterModel({
		this.id, 
		this.email, 
		this.phone, 
		this.fullName, 
		this.isActive, 
		this.code, 
		this.role, 
		this.createdAt, 
		this.updatedAt, 
	});

	factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
				id: json['id'] as String?,
				email: json['email'] as String?,
				phone: json['phone'] as String?,
				fullName: json['fullName'] as String?,
				isActive: json['isActive'] as bool?,
				code: json['code'] as dynamic,
				role: json['role'] as String?,
				createdAt: json['createdAt'] == null
						? null
						: DateTime.parse(json['createdAt'] as String),
				updatedAt: json['updatedAt'] == null
						? null
						: DateTime.parse(json['updatedAt'] as String),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'email': email,
				'phone': phone,
				'fullName': fullName,
				'isActive': isActive,
				'code': code,
				'role': role,
				'createdAt': createdAt?.toIso8601String(),
				'updatedAt': updatedAt?.toIso8601String(),
			};
}
