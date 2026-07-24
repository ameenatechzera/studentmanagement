package com.techzera.studentmanagement

import org.json.JSONArray
import org.json.JSONObject

object JsonConverter {
    fun convertToMap(json: JSONObject): Map<String, Any?> {
        return if (json != JSONObject.NULL) toMap(json) else HashMap()
    }

    private fun toMap(obj: JSONObject): Map<String, Any?> {
        val map = HashMap<String, Any?>()
        val keys = obj.keys()
        while (keys.hasNext()) {
            val key = keys.next()
            var value = obj.get(key)
            when (value) {
                is JSONArray -> value = toList(value)
                is JSONObject -> value = toMap(value)
            }
            map[key] = value
        }
        return map
    }

    private fun toList(array: JSONArray): List<Any?> {
        val list = ArrayList<Any?>()
        for (i in 0 until array.length()) {
            var value = array.get(i)
            when (value) {
                is JSONArray -> value = toList(value)
                is JSONObject -> value = toMap(value)
            }
            list.add(value)
        }
        return list
    }
}