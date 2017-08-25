# Objects
## User
1. email: String
2. user_id: timeuuid
3. user_name: String
4. password: encrypted
5. gender: String
6. birthday: timestamp

## Workout
1. body_parts: [String]
2. name: String
3. created_date: Date
4. sections: [Section]

## Workout
1. index: Int
2. name: String
3. created_date: Date
4. Exercises: [Exercise]

## Exercise
1. name: String
2. weight: Int
3. weight_unit: String
4. reps: Int

# Modules
## Login
1. Login
2. Login with Facebook
3. Signup

## Current Workout
1. If no active workout
