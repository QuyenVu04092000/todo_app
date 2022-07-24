const express = require("express");
const router = express.Router();
//Models
const Todo = require('../models/Todo');
const Task = require('../models/Task');
//Insert
router.post("/", async (req, res) => {
    let { todoid, name, isfinished} = req.body;
    try {
        let newTask = await Task.create({
            todoid,
            name,
            isfinished
        }, {
            fields: ["todoid","name", "isfinished"]
        });
        if(newTask){
            res.json({
                result: 'ok',
                data: newTask
            });
        } else {
            res.json({
                result: 'failed',
                data: {},
                message: 'Insert a new Task failed'
            });
        }
    } catch(error){
        res.json({
            result: 'failed',
            data: {},
            message: 'Insert a new Task failed. Error:' + error
        });
    }
});
//Update data in DB
router.put('/:id', async (req,res) => {
    const {id} = req.params;
    const {todoid, name, isfinished} = req.body;
    try {
        let tasks = await Task.findAll({
            attributes: ['id', 'todoid', 'name', 'isfinished'],
            where: {
                id
            }
        });
        if(tasks.length > 0){
            tasks.forEach(async (task) => {
                await task.update({
                    todoid: todoid ? todoid : task.todoid,
                    name: name ? name : task.name,
                    isfinished: isfinished ? isfinished : task.isfinished
                });
            });
            res.json({
                result: 'ok',
                data: tasks,
                message: "update a Task successfully"
            });
        } else {
            res.json({
                result: 'failed',
                data: {},
                message: "Cannot find Task to update"
            });
        }
    } catch(error){
        res.json({
            result: 'failed',
            data: {},
            message: "Cannot update a Task. Error: " + error
        });
    }
});
//Delete a Todo
router.delete('/:id', async (req,res) => {
    let {id} = req.params;
    try {
        let numberOfDeletedRows = await Task.destroy({
            where: {
                id
            }
        });
        res.json({
            result: 'ok',
            message: "Delete a Task successfully",
            count: numberOfDeletedRows
        });
    } catch(error){
        res.json({
            result: 'failed',
            data: {},
            message: "Delete a Task failed. Error: " + error
        });
    }
});
//Query all data from DB
router.get('/', async (req, res) => {
    try {
        const tasks = await Task.findAll({
            attributes: ['id', 'todoid', 'name', 'isfinished'],
            order: [
                ['name', 'ASC']
            ],
        });
        res.json({
            result: 'ok',
            data: tasks,
            message: "query list of Tasks successfully"
        });
    } catch(error) {
        res.json({
            result: 'failed',
            data: [],
            message: 'query list of Tasks failed. Error: ' + error
        });
    }
});
//Get by Id
router.get('/:id', async (req, res) => {
    const {id} = req.params;
    try {
        let tasks = await Task.findAll({
            attributes: ['id', 'todoid', 'name', 'isfinished'],
            where: {
                id
            },
        });
        if (tasks.length > 0){
            res.json({
                result: 'ok',
                data: tasks[0],
                message: "query list of tasks successfully"
            });
        } else {
            res.json({
                result: 'failed',
                data: {},
                message: "Cannot find task to show"
            });
        }
    } catch(error){
        res.json({
            result: 'failed',
            data: {},
            message: 'query list of Todos(by id) failed. Error: ' + error
        });
    }
});
//Query by todoid
router.get('/todoid/:todoid', async (req, res) => {
    let { todoid } = req.params;
    try {
        let tasks = await Task.findAll({
            attributes: ["id", "todoid", "name", "isfinished"],
            where: {
                todoid
            }
        });
        res.json({
            result: 'ok',
            data: tasks,
            message: "query list of Tasks successfully"
        });
    } catch (error) {
        res.json({
            result: 'failed',
            data: {},
            message: `query list of Tasks(by id) failed. Error: ${error}`
        });
    }
});
module.exports = router;