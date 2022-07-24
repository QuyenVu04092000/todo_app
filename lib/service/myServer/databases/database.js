const DATABASE_URL = 'postgres://aubizefufmlwvx:85baa6bc2d4b6020dedba1dec7b1533f3ba75fa20e2a9d462768e9956cb86645@ec2-3-219-52-220.compute-1.amazonaws.com:5432/d3p13ti4gsc97b?ssl=true';
const Sequelize = require('sequelize');
const sequelize = new Sequelize(
    'd3p13ti4gsc97b',
    'aubizefufmlwvx',
    '85baa6bc2d4b6020dedba1dec7b1533f3ba75fa20e2a9d462768e9956cb86645',
    {
        dialect: 'postgres',
        host: 'ec2-3-219-52-220.compute-1.amazonaws.com',
        dialectOptions: {
            ssl: {
                require: true,
                rejectUnauthorized: false
            }
        },
        pool: {
            max: 5,
            min: 0,
            require: 30000,
            idle: 10000
        }
    }
);
const Op = Sequelize.Op;
module.exports = {
    sequelize,
    Op
}