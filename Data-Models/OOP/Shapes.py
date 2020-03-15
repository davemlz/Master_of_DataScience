'''
This module provides the implementation of new classes of type Shapes with three basic objects: Circle, Rectangle and Triangle.

Arithmetic operations such as addition, subtraction, multiplication and division are implemented for the new classes.

Comparations for logical operators such as <,<=,==,!=,>,>= are also implemented.
'''

from numpy import pi

class Shapes(object):
    '''
    Shapes object.

    Parameters
    ----------
    params : list
        List of n numbers used as parameters of a shape: [parameter a, parameter b,..., parameter n].    

    Attributes
    ----------
    params : list
        List of n numbers used as parameters of a shape.
    
    Raises
    ------
    TypeError
        Raised when params elements are not numeric.
    ValueError
        Raised if any element in params is negative or equal to zero.
    NotImplementedError
        Raised for the __repr__ and __str__ methods.
    '''
    
    def __init__(self,params):
                
        for i in params:            
            if type(i) is not int and type(i) is not float:
                raise TypeError("I need numbers!")
            else:
                if i <= 0:
                    raise ValueError("Parameters must be positive!")
            
        self.params = params
    
    def __repr__(self):
        raise NotImplementedError("This method is not implemented!")
    
    def __str__(self):
        raise NotImplementedError("This method is not implemented!")        
    
    def __add__(self,other):
        '''Add two shape objects or a shape object and a number.

        Parameters
        ----------
        self : Shape object
            This object
        other : Shape object, numeric, list
            Another object with the same type of self, or a numeric, or a list of numeric

        Returns
        -------
        Shape object
            Returns an object of the same type of self with the sum of each parameter from each object.
        '''
        
        if type(self) == type(other):            
            return type(self)([self.params[i] + other.params[i] for i in range(len(self.params))])
        
        elif isinstance(other,list):
            if len(other) == len(self.params):                
                return type(self)([self.params[i] + other[i] for i in range(len(self.params))])
            else:
                raise ValueError("The list needs the same length of elements that the shape parameters have!")
                
        else:
            return type(self)([self.params[i] + other for i in range(len(self.params))])            
    
    def __sub__(self,other):
        '''Subtract two shape objects or a shape object and a number.

        Parameters
        ----------
        self : Shape object
            This object
        other : Shape object, numeric, list
            Another object with the same type of self, or a numeric, or a list of numeric

        Returns
        -------
        Shape object
            Returns an object of the same type of self with the subtract of each parameter from each object.
        '''
        
        if type(self) == type(other):            
            return type(self)([self.params[i] - other.params[i] for i in range(len(self.params))])
        
        elif isinstance(other,list):
            if len(other) == len(self.params):                
                return type(self)([self.params[i] - other[i] for i in range(len(self.params))])
            else:
                raise ValueError("The list needs the same length of elements that the shape parameters have!")
                
        else:
            return type(self)([self.params[i] - other for i in range(len(self.params))])            
        
    def __mul__(self,other):
        '''Multiply two shape objects or a shape object and a number.

        Parameters
        ----------
        self : Shape object
            This object
        other : Shape object, numeric, list
            Another object with the same type of self, or a numeric, or a list of numeric

        Returns
        -------
        Shape object
            Returns an object of the same type of self with the multiplication of each parameter from each object.
        '''
        
        if type(self) == type(other):
            return type(self)([self.params[i] * other.params[i] for i in range(len(self.params))])            
        
        elif isinstance(other,list):
            if len(other) == len(self.params):                
                return type(self)([self.params[i] * other[i] for i in range(len(self.params))])
            else:
                raise ValueError("The list needs the same length of elements that the shape parameters have!")
                
        else:
            return type(self)([self.params[i] * other for i in range(len(self.params))])            
        
    def __truediv__(self,other):
        '''Divide two shape objects or a shape object and a number.

        Parameters
        ----------
        self : Shape object
            This object
        other : Shape object, numeric, list
            Another object with the same type of self, or a numeric, or a list of numeric

        Returns
        -------
        Shape object
            Returns an object of the same type of self with the division of each parameter from each object.
        '''
        
        if type(self) == type(other):
            return type(self)([self.params[i] / other.params[i] for i in range(len(self.params))])            
        
        elif isinstance(other,list):
            if len(other) == len(self.params):                
                return type(self)([self.params[i] / other[i] for i in range(len(self.params))])
            else:
                raise ValueError("The list needs the same length of elements that the shape parameters have!")
                
        else:
            return type(self)([self.params[i] / other for i in range(len(self.params))])            
    
    def __radd__(self,other):
        if isinstance(other,list):
            if len(other) == len(self.params):                
                return type(self)([self.params[i] + other[i] for i in range(len(self.params))])
            else:
                raise ValueError("The list needs the same length of elements that the shape parameters have!")
        else:
            return type(self)([self.params[i] + other for i in range(len(self.params))])            
    
    def __rsub__(self,other):
        if isinstance(other,list):
            if len(other) == len(self.params):                
                return type(self)([other[i] - self.params[i] for i in range(len(self.params))])
            else:
                raise ValueError("The list needs the same length of elements that the shape parameters have!")
        else:
            return type(self)([other - self.params[i] for i in range(len(self.params))])              
    
    def __rmul__(self,other):
        if isinstance(other,list):
            if len(other) == len(self.params):                
                return type(self)([other[i] * self.params[i] for i in range(len(self.params))])
            else:
                raise ValueError("The list needs the same length of elements that the shape parameters have!")
        else:
            return type(self)([other * self.params[i] for i in range(len(self.params))])                
    
    def __rtruediv__(self,other):
        if isinstance(other,list):
            if len(other) == len(self.params):                
                return type(self)([other[i] / self.params[i] for i in range(len(self.params))])
            else:
                raise ValueError("The list needs the same length of elements that the shape parameters have!")
        else:
            return type(self)([other / self.params[i] for i in range(len(self.params))])                 
    
    def __lt__(self, other):
        '''Compare if this shape object is lower than other shape object.

        Parameters
        ----------
        self : Shape object
            This object
        other : Shape object
            Another shape object

        Returns
        -------
        boolean
        '''
        
        return self.area < other.area
    
    def __le__(self, other):
        '''Compare if this shape object is lower or equal than other shape object.

        Parameters
        ----------
        self : Shape object
            This object
        other : Shape object
            Another shape object

        Returns
        -------
        boolean
        '''
        
        return self.area <= other.area
    
    def __eq__(self, other):
        '''Compare if this shape object is equal than other shape object.

        Parameters
        ----------
        self : Shape object
            This object
        other : Shape object
            Another shape object

        Returns
        -------
        boolean
        '''
        
        return self.area == other.area
    
    def __ne__(self, other):
        '''Compare if this shape object is not equal than other shape object.

        Parameters
        ----------
        self : Shape object
            This object
        other : Shape object
            Another shape object

        Returns
        -------
        boolean
        '''
        
        return self.area != other.area
    
    def __gt__(self, other):
        '''Compare if this shape object is greater than other shape object.

        Parameters
        ----------
        self : Shape object
            This object
        other : Shape object
            Another shape object

        Returns
        -------
        boolean
        '''
        
        return self.area > other.area
    
    def __ge__(self, other):
        '''Compare if this shape object is greater or equal than other shape object.

        Parameters
        ----------
        self : Shape object
            This object
        other : Shape object
            Another shape object

        Returns
        -------
        boolean
        '''
        
        return self.area >= other.area    

class Circle(Shapes):
    '''
    Circle object.

    Parameters
    ----------
    params : list, numeric
        List of 1 number or a number used as the radius of the circle.    

    Attributes
    ----------
    params : list
        List or numeric of size 1 used as the redius of the circle.
    radius : numeric
        Circle radius    
    area : numeric
        Circle area
        
    Raises
    ------
    TypeError
        Raised when params is not numeric.
    ValueError
        Raised when there is not one element in params or if it is negative or equal to zero.
    '''
    
    def __init__(self,r):
        
        if not isinstance(r,list):
            r = [r]
        
        if len(r) == 1:
            super().__init__(r)
        else:
            raise ValueError("Too many parameters! Just need the radius!")
            
        self.radius = r[0]
        self.area = pi * self.radius ** 2
        
    def __repr__(self):
        return "<Circle (radius = " + str(self.radius) + ", area = " + str(self.area) + ")>"
    
    def __str__(self):
        return "Circle (radius = " + str(self.radius) + ", area = " + str(self.area) + ")"

class Rectangle(Shapes):
    '''
    Rectangle object.

    Parameters
    ----------
    params : list
        List of two numbers used as height and width of the rectangle: [height,width].    

    Attributes
    ----------
    params : list
        List of two numbers used as height and width of the rectangle.
    height : numeric
        Rectangle height
    width : numeric
        Rectangle width    
    area : numeric
        Rectangle area
        
    Raises
    ------
    TypeError
        Raised when params is not a list or when its elements are not numeric.
    ValueError
        Raised when there are not two elements in params or if any element is negative or equal to zero.
    '''
    
    def __init__(self,params):
        
        if not isinstance(params,list):
            raise TypeError("I just need a list with the two parameters!")
        
        if len(params) == 2:
            super().__init__(params)
        else:
            raise ValueError("I need two parameters!")
            
        self.height = params[0]
        self.width = params[1]
        self.area = self.height * self.width
        
    def __repr__(self):
        return "<Rectangle (Height = " + str(self.height) + ", Width = " + str(self.width) + ", area = " + str(self.area) + ")>"
    
    def __str__(self):
        return "Rectangle (Heigth = " + str(self.height) + ", Width = " + str(self.width) + ", area = " + str(self.area) + ")"

class Triangle(Shapes):
    '''
    Triangle object.

    Parameters
    ----------
    params : list
        List of three numbers used as each side of the triangle: [side a,side b,side c].    

    Attributes
    ----------
    params : list
        List of three numbers used as each side of the triangle.
    a : numeric
        Triangle side a
    b : numeric
        Triangle side b
    c : numeric
        Triangle side c
    area : numeric
        Triangle area
    
    Raises
    ------
    TypeError
        Raised when params is not a list or when its elements are not numeric.
    ValueError
        Raised when there are not three elements in params or if any element is negative or equal to zero.
    AttributeError
        Raised when the sum of two sides is not higher than the remaining side for each pair of sides.
    '''
    
    def __init__(self,params):
        
        if not isinstance(params,list):
            raise TypeError("I just need a list with the three parameters!")
        
        if len(params) == 3:
            super().__init__(params)
        else:
            raise ValueError("I need three parameters!")
            
        self.a = params[0]
        self.b = params[1]
        self.c = params[2]
        
        if self.a + self.b > self.c and self.a + self.c > self.b and self.c + self.b > self.a:           

            s = (self.a + self.b + self.c)/2
            self.area = (s * (s - self.a) * (s - self.b) * (s - self.c)) ** (1/2)
            
        else:

            raise AttributeError("The sum of two sides must be higher than the remaining side for each pair of sides!")
       
    def __repr__(self):
        return "<Triangle (a = " + str(self.a) + ", b = " + str(self.b) + ", c = " + str(self.c) + ", area = " + str(self.area) + ")>"
    
    def __str__(self):
        return "Triangle (a = " + str(self.a) + ", b = " + str(self.b) + ", c = " + str(self.c) + ", area = " + str(self.area) + ")"
    