'use strict';
Object.defineProperty(exports, '__esModule', { value: true });

// 获取配置信息的函数
function getConfig(key) {
	const config = {
		port: 3200,  // 端口号，确保没有被占用
		mysql_config: {  // MySQL配置信息
			dialect: 'mysql',
			host: '172.18.0.2',  // 数据库主机地址, 容器部署使用services里的名字即可
			port: 3306,  // 数据库端口号，默认3306
			username: 'root',  // 数据库用户名
			password: 'my-secret-pw',  // 数据库密码
			database: 'chatgpt',  // 数据库名称
			timezone: '+08:00',
			dialectOptions: {
				dateStrings: true,
				typeCast: true
			}
		},
		redis_config: {  // Redis配置信息，一般不用改
			type: 'redis',
			host: '172.18.0.4', // 容器部署使用services里的名字即可
			port: 6379,
			password: 'my-secret-pw'
		},
		email: 'admin@oneele.com',  // 邮件地址
		email_config: {  // 邮件配置信息
			host: 'smtp.exmail.qq.com',  // SMTP服务器地址
			port: 465,  // SMTP服务器端口号
			ignoreTLS: false,  // 是否忽略TLS
			secure: true,  // 是否使用安全连接
			auth: {
				user: 'admin@oneele.com',  // SMTP服务器用户名
				pass: 'rdD6qmW6YnUh4Pbf'  // SMTP服务器密码
			}
		}
	};
	if (key) {
		return config[key];
	}
	return config;
}

exports.default = {
	getConfig
};

//# sourceMappingURL=index.js.map
