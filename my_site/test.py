class StackObj:
    def __init__(self, data):
        self.__data = data
        self.__next = None

    @property
    def next(self):
        return self.__next

    @next.setter
    def next(self, value):
        if isinstance(value, StackObj) or value == None:
            self.__next = value

    @property
    def data(self):
        return self.__data

    @data.setter
    def data(self, value):
        self.__data = value

class Stack:
    def __init__(self):
        self.top = None
        self.tail = None

    def push(self, obj):
        if not self.top:
            self.top = obj
        elif not self.tail:
            self.tail = StackObj(data=obj.data)
            self.top.next = self.tail
        else:
            self.tail.next = obj
            self.tail = obj
            # node = obj
            # node.next = self.top
            # self.top = node
        return obj

    def pop(self):
        if not self.top:
            return None
        elif self.top.next == None:
            node = StackObj(data=self.top.data)
            self.top = None
            return node
        else:
            node = self.top
            while node:
                if node.next.next == None:
                    last = StackObj(data=node.next.data)
                    node.next = None
                    return last
                node = node.next

    def get_data(self):
        data = []
        node = self.top
        while node:
            data.append(node.data)
            node = node.next
        return data


st = Stack()
st.push(StackObj("obj1"))
# st.push(StackObj("obj2"))
# st.push(StackObj("obj7"))
# st.push(StackObj("obj7"))
# st.push(StackObj("obj9"))
# st.push(StackObj("obj10"))
st.pop()
print(st.pop())
res = st.get_data()    # ['obj1', 'obj2']
print(res)
