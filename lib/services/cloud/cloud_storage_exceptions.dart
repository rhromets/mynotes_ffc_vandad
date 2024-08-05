class CloudStorageException implements Exception {
  const CloudStorageException();
}

// Create in CRUD
class CouldNotCreateNoteException extends CloudStorageException {}

// Read in CRUD
class CouldGetAllNotesException extends CloudStorageException {}

// Update in CRUD
class CouldNotUpdateNoteException extends CloudStorageException {}

// Delete in CRUD
class CouldNotDeleteNoteException extends CloudStorageException {}
