import SwiftUI
struct ContentView: View {
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos:FetchedResults<Todo>
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var showingAddTodoView: Bool = false
    
    var body: some View{
        NavigationView{
            List{
                ForEach(self.todos, id: \.self) { todo in
                    HStack{
                        Text(todo.name ?? "Unknown")
                        Spacer()
                        Text(todo.priority ?? "Unkown")
                    }
                }
                .onDelete(perform: deleteTodo)
            }//: LIST
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(
                leading:EditButton(),
                trailing:
                Button(action: {
                    self.showingAddTodoView.toggle()
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showingAddTodoView){
                    AddToDo().environment(\.managedObjectContext, self.managedObjectContext)
                }
            )
        }
        }
    
    private func deleteTodo(at offsets: IndexSet){
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
}
struct ContentView_Preview: PreviewProvider{
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro")
    }
}
